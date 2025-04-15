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
        gleam
        erlang    # required for gleam
        rebar3    # erlang build tool that makes it easy to compile and test
      ];
      shellHook = ''
        alias gt="gleam test"
        alias gb="gleam build"
        alias gr="gleam run"
        alias gs="gleam shell"

        function exercism-submit(){
            local message="Gleam $(basename $(pwd))"
            echo "$message"
            exercism submit
            git add --all
            git commit -m "$message"
        }
        alias es="exercism-submit"
        
        function exer-download(){
          exercism download --track=gleam --exercise=$1
          cd $SOURCE_JEFF/exercism/gleam/$1
        }
        alias ed="exer-download"

        function exer-edit(){
          cd $SOURCE_JEFF/exercism/gleam/$1
          hx **/*.gleam
        }
        alias ee="exer-edit"
        
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
