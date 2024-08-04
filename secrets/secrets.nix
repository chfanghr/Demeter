let
  master = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBmGxwcswrJNNjgKYV8WxhFKDIUtrUSM/JwC4HT8sDjX fanghr@Demeter";
  athena = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyVzMHW3wrVYygLvd2S6QfhrDYMNuzALQaJAGPzEoYm root@Athena";
in {
  "outbound-server.json.age".publicKeys = [master athena];
}
