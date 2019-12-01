# Hello world docker action

This action runs cargo to build rust projects.

## Example

```yaml
  - name: build
    uses: cmsd2/lambda-rust-cargo
    with:
      args: build
```
