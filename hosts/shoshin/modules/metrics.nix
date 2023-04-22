{ config, lib, pkgs, ... }:


let lokiPort = 3100;
    prometheusPort = 9090;
    prometheusNodePort = 9100;
in {
  ### Grafana
  user.extraGroups = [ "grafana" ];
  services.grafana = {
    enable = false;
    domain = "stats.cherma.org";
  };
  services.nginx.virtualHosts = {
    "stats.cherma.org" = {
      http2 = true;
      forceSSL = true;
      enableACME = true;
      extraConfig = ''if ($deny) { return 503; }'';
      locations."/" = {
        proxyPass = "http://127.0.0.0:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
      };
    };
  };


  ### Collectors
  services.prometheus = {
    enable = false;
    port = prometheusPort;
    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
      port = prometheusNodePort;
    };
    scrapeConfigs = [
      {
        job_name = "home";
        static_configs = [
          {
            targets = [
              "127.0.0.0:${toString prometheusNodePort}"
              # "10.1.0.2:${toString prometheusNodePort}"
            ];
          }
        ];
      }
      {
        job_name = "remote";
        static_configs = [
          {
            targets = [
              "10.1.0.10:${toString prometheusNodePort}"
              "10.1.0.11:${toString prometheusNodePort}"
            ];
          }
        ];
      }
    ];
  };

  services.loki = {
    enable = false;
    configuration = {
      auth_enabled = false;
      server = {
        http_listen_port = lokiPort;
        log_level = "warn";
      };
      ingester = {
        lifecycler = {
          address = "127.0.0.1";
          ring = {
            kvstore.store = "inmemory";
            replication_factor = 1;
          };
          final_sleep = "0s";
        };
        chunk_idle_period = "5m";
        chunk_retain_period = "30s";
      };
      schema_config = {
        configs = [
          {
            from = "2022-05-06";
            store = "boltdb";
            object_store = "filesystem";
            schema = "v11";
            index = {
              prefix = "index_";
              period = "48h";
            };
          }
        ];
      };
      storage_config = {
        boltdb.directory = "/tmp/loki/index";
        filesystem.directory = "/tmp/loki/chunks";
      };
      limits_config = {
        enforce_metric_name = false;
        reject_old_samples = true;
        reject_old_samples_max_age = "168h";
      };
      # ruler = {
      #   alertmanager_url = "http://localhost:9093";
      # };
      analytics = {
        reporting_enabled = false;
      };
    };
  };
  services.promtail = {
    enable = false;
    configuration = {
      server = {
        http_listen_port = 28183;
        grpc_listen_port = 0;
        log_level = "warn";
      };
      positions.filename = "/tmp/positions.yaml";
      clients = [
        { url = "http://127.0.0.1:${toString lokiPort}/loki/api/v1/push"; }
      ];
      scrape_configs = [
        {
          job_name = "journal";
          journal = {
            max_age = "24h";
            labels = {
              job = "systemd-journal";
              host = "127.0.0.1";
            };
          };
          relabel_configs = [
            {
              source_labels = [ "__journal__systemd_unit" ];
              target_label = "unit";
            }
          ];
        }
      ];
    };
  };
}
