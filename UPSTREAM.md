# Upstream sync

This translation is based on the English original:

- **Repo:** https://github.com/beejjorgensen/bggit
- **Commit:** `756463786f1dcb44a59b8ed136a119219101aace`
- **Version:** v1.2.8 (April 18, 2026)

Update this file when syncing from a newer upstream commit. The release
workflow reads it to embed provenance in the release notes.

## Release tags

We tag translation releases as:

    v<UPSTREAM_VERSION>-vi.<N>

For example, `v1.2.8-vi.1` is the first Vietnamese release based on
upstream v1.2.8. Subsequent translation fixes against the same upstream
version bump `N` (`v1.2.8-vi.2`, ...). When upstream bumps their version,
we restart `N` at 1 (`v1.2.9-vi.1`).

Use `scripts/release.sh` to create and push a tag; the
`.github/workflows/release.yml` workflow then builds and publishes a
GitHub Release with all artifacts.
