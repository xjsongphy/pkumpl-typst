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

# Regenerate the Universe template thumbnail from the initialized template.
thumbnail:
    #!/usr/bin/env bash
    set -euo pipefail
    package_path="$(mktemp -d)"
    project_root="$(mktemp -d)/project"
    trap 'rm -rf "$package_path" "${project_root%/project}"' EXIT
    mkdir -p "$package_path/preview/unofficial-pku-mpl/0.1.0"
    cp typst.toml README.md README_zh.md LICENSE mplts.typ "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    cp -R template images "$package_path/preview/unofficial-pku-mpl/0.1.0/"
    TYPST_PACKAGE_PATH="$package_path" typst init @preview/unofficial-pku-mpl:0.1.0 "$project_root"
    TYPST_PACKAGE_PATH="$package_path" typst compile --format png --pages 1 --ppi 250 "$project_root/main.typ" images/thumbnail.png
    echo "Regenerated images/thumbnail.png"

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
    destination="$packages_repo/packages/preview/$name/$version"
    if [[ -e "$destination" ]]; then
        echo "Error: destination already exists: $destination" >&2
        exit 1
    fi
    mkdir -p "$destination"
    cp typst.toml README.md README_zh.md LICENSE mplts.typ "$destination/"
    cp -R template images "$destination/"
    echo "Prepared $name v$version at $destination"
