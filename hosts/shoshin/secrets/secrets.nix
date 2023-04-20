  let
    hkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9Uu0BuMuMxjfXawQya07boc8ZltvPaWMQmWFws3OoG";
	  ukey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKFmXmnKqwP7SlR7epj8Y3xQQXTRrZZn+/N8uWBumpI hermannschris@googlemail.com";


in
  {
    "paperless-adminCredentials.age".publicKeys = [ hkey ukey ];
  }
