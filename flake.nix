{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
  outputs = { nixpkgs, ... }:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in {
    devShell.aarch64-darwin = pkgs.mkShell {
    	name = "gleam";
      packages = with pkgs; [
        exercism
        glow      # mark down
        gleam
        erlang    # required for gleam
        rebar3    # erlang build tool that makes it easy to compile and test
      ];
      shellHook = ''
        source .envrc
                
        echo -e "\e[1;94m == gleam shell  =="
        exercism version
        gleam --version
        echo "erlang version: $(erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell)"
        rebar3 --version
        echo -e "\e[0m"
      '';
    };
  };
}
