deploy:
	nix build .#darwinConfigurations.MacBook-Pro-de-Matheo.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#MacBook-Pro-de-Matheo

