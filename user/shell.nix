
{ pkgs, ... }:
{
	programs.bash.initExtra = ''
		take() {
			if [ -d "\${1}" ]; then
				cd "\${1}"
			else
				mkdir -p "\${1}"
				cd "\${1}"
			fi
		}
	'';

}
