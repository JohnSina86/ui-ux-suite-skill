# Judge plumbing check: one image, echo rule

Call: codex exec -m gpt-6-astra --sandbox read-only -i shot-375.png -o echo-test.md "<prompt>" (2026-10-13)

## Prompt
```text
You are given one screenshot of a web page at phone width. This is a plumbing test of image input, not a design judgement. First, name one concrete visual detail you can see in the image (a colour, a word on screen, a position, a size relation). Then say in one sentence whether the image was actually attached. End with exactly one JSON line: {"detail": "...", "attached": true or false}
```

## Image
shot-375.png, 375×812, headless Chrome 154 of the allowlist test page served at http://127.0.0.1:4181/ (heading colour #9b2c2c on #f4efe6).

## Reply
```text
The heading “Allowlist test page” is dark red near the top.
The image was actually attached.
{"detail":"The heading “Allowlist test page” is dark red near the top.","attached":true}
```

## Usage (stderr)
```text
tokens used
6,833
```

Echo rule: the detail is in the image. Valid.
