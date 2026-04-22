let
	nixpkgs = fetchTarball {
		url="https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
		sha256="0ayx6v3wwvqpdjkbfnbgyp7rwnsypgn6willidza61x9ilmxkqdp";
	};
	pkgs = import nixpkgs { 
		config = {
			allowUnfree = true;
		}; 
		overlays = []; 
	};
in

pkgs.mkShellNoCC {
	packages = with pkgs; [
		bash
		neovim
		tree
		git
		tmux
		python312
		python312Packages.fastapi
		python312Packages.uvicorn
	];

	# Set bash as the shell
	shell = "${pkgs.bash}/bin/bash";

	shellHook = ''
		alias v='nvim'
		alias vi='nvim'
		alias vim='nvim'
	'';
}
