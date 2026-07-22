# List available development commands.
default:
    @just --list

# Compile the complete local demonstration document.
compile:
    typst compile demo.typ demo.pdf

# Watch the local demonstration document while editing.
watch:
    typst watch demo.typ

# Verify that the package can initialize and compile a fresh project locally.
check-init:
    #!/usr/bin/env bash
    set -euo pipefail
    package_path="$(mktemp -d)"
    project_root="$(mktemp -d)/project"
    trap 'rm -rf "$package_path" "${project_root%/project}"' EXIT
    mkdir -p "$package_path/preview/unofficial-pku-mpl/0.1.0"
    cp typst.toml README.md README_zh.md LICENSE mplts.typ "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    cp -R template images "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    TYPST_PACKAGE_PATH="$package_path" typst init @preview/unofficial-pku-mpl:0.1.0 "$project_root"
    TYPST_PACKAGE_PATH="$package_path" typst compile "$project_root/main.typ" "$project_root/main.pdf"
    echo "Initialized template compiled successfully: $project_root/main.pdf"

# Validate files and metadata that are easy for the Universe bot to reject.
check-release:
    #!/usr/bin/env bash
    set -euo pipefail
    name="$(awk -F'"' '/^name/ {print $2; exit}' typst.toml)"
    version="$(awk -F'"' '/^version/ {print $2; exit}' typst.toml)"
    for required in README.md LICENSE mplts.typ template/main.typ template/bibli.bib template/american-physics-society.csl images/firstpage.png; do
        test -e "$required" || { echo "Missing release file: $required" >&2; exit 1; }
    done
    for required in template/bibli.bib template/american-physics-society.csl; do
        basename="${required##*/}"
        if rg -n --fixed-strings "\"$basename\"" typst.toml >/dev/null; then
            echo "Release file is excluded by typst.toml: $required" >&2
            exit 1
        fi
    done
    while IFS= read -r link; do
        test -e "$link" || { echo "README link target is missing: $link" >&2; exit 1; }
    done < <(rg -o '\]\(\./[^)#]+' README.md | sed 's/^](//')
    for doc in README.md template/main.typ; do
        if rg -n --fixed-strings "@preview/$name:" "$doc" | rg -v --fixed-strings "@preview/$name:$version" >/dev/null; then
            echo "Stale package version reference found in $doc (expected $version)." >&2
            exit 1
        fi
    done
    license="$(awk -F'"' '/^license/ {print $2; exit}' typst.toml)"
    case "$license" in
        CC-*|CC0-*)
            echo "Notice: $license is allowed by Typst's licensing policy but may be flagged by the current OSI-only package checker." >&2
            ;;
    esac
    just check-init >/dev/null
    echo "Release package checks passed."

# Regenerate the Universe template preview from the initialized first page.
firstpage:
    #!/usr/bin/env bash
    set -euo pipefail
    package_path="$(mktemp -d)"
    project_root="$(mktemp -d)/project"
    trap 'rm -rf "$package_path" "${project_root%/project}"' EXIT
    mkdir -p "$package_path/preview/unofficial-pku-mpl/0.1.0"
    cp typst.toml README.md README_zh.md LICENSE mplts.typ "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    cp -R template images "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    TYPST_PACKAGE_PATH="$package_path" typst init @preview/unofficial-pku-mpl:0.1.0 "$project_root"
    TYPST_PACKAGE_PATH="$package_path" typst compile --format png --pages 1 --ppi 250 "$project_root/main.typ" images/firstpage.png
    echo "Regenerated images/firstpage.png"

# Copy a release-ready package into a local checkout of typst/packages.
publish:
    #!/usr/bin/env bash
    set -euo pipefail
    name="$(awk -F'"' '/^name/ {print $2; exit}' typst.toml)"
    version="$(awk -F'"' '/^version/ {print $2; exit}' typst.toml)"
    packages_repo="${TYPST_PACKAGES_REPO:-}"
    if [[ -z "$packages_repo" ]]; then
        echo "Error: set TYPST_PACKAGES_REPO to your typst/packages checkout" >&2
        exit 1
    fi
    just check-release
    destination="$packages_repo/packages/preview/$name/$version"
    if [[ -e "$destination" ]]; then
        echo "Error: destination already exists: $destination" >&2
        exit 1
    fi
    mkdir -p "$destination"
    cp typst.toml README.md README_zh.md LICENSE mplts.typ "$destination/"
    cp -R template images "$destination/"
    echo "Prepared $name v$version at $destination"
