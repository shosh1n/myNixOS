  let 
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKFmXmnKqwP7SlR7epj8Y3xQQXTRrZZn+/N8uWBumpI hermannschris@googlemail.com";
  
  in {
    "paperless-auth.age".publicKeys = [ key ];
    }
