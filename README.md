# Arnavxy Homebrew Tap

Homebrew formulae for open-source projects by
[@Arnavxy](https://github.com/Arnavxy).

## cu

[`cu`](https://github.com/Arnavxy/cu) is a fast, token-aware computer-use
runtime for macOS agents. Install it with:

```bash
brew install Arnavxy/tap/cu
```

Then grant Accessibility—and Screen Recording when using screenshots or
OCR—to the terminal or agent process that runs `cu`:

```bash
cu doctor
```

Homebrew installs the `cliclick` dependency and builds the native Swift helper
from the tagged source release.

## Updating

```bash
brew update
brew upgrade cu
```

## Uninstalling

```bash
brew uninstall cu
```
