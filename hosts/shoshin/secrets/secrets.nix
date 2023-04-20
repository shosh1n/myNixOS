  let 
   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClElwl33CnzGzW6IEcPsbwdqAkDFhst/TzUZUGMwwTb shoshin";

in
  {
    "paperless-adminCredentials.age".publicKeys = [ key ];
  }
