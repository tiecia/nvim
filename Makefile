NIX ?= nix

.PHONY: check check-local format format-check health lint nix-check smoke update

format:
	$(NIX) develop path:. --command stylua .

format-check:
	$(NIX) develop path:. --command stylua --check .

lint:
	$(NIX) develop path:. --command scripts/lint-lua.sh

smoke:
	$(NIX) develop path:. --command scripts/smoke.sh

nix-check:
	$(NIX) flake check path:.

check-local:
	stylua --check .
	scripts/lint-lua.sh
	scripts/smoke.sh

check:
	$(NIX) develop path:. --command make check-local
	$(NIX) flake check path:.

health:
	$(NIX) develop path:. --command nvim --headless '+checkhealth config' '+qa'

update:
	$(NIX) develop path:. --command nvim --headless '+Lazy! update' '+qa'
	$(NIX) flake update
