> ## Documentation Index
> Fetch the complete documentation index at: https://hyperframes.mintlify.app/llms.txt
> Use this file to discover all available pages before exploring further.

# Spotify Now Playing

> Animated Spotify now-playing card with album art and progress bar

# Spotify Now Playing

Animated Spotify now-playing card with album art and progress bar

`social` `overlay` `spotify`

<video className="w-full aspect-video rounded-xl object-cover bg-zinc-100 dark:bg-zinc-800" src="https://static.heygen.ai/hyperframes-oss/docs/images/catalog/blocks/spotify-card.mp4" poster="https://static.heygen.ai/hyperframes-oss/docs/images/catalog/blocks/spotify-card.png" autoPlay muted loop playsInline />

## Install

<CodeGroup>
  ```bash Terminal theme={null}
  npx hyperframes add spotify-card
  ```
</CodeGroup>

## Details

| Property   | Value     |
| ---------- | --------- |
| Type       | Block     |
| Dimensions | 1080×1920 |
| Duration   | 5s        |

## Files

| File                | Target                           | Type                    |
| ------------------- | -------------------------------- | ----------------------- |
| `spotify-card.html` | `compositions/spotify-card.html` | hyperframes:composition |

## Usage

After installing, add the block to your host composition:

```html theme={null}
<div data-composition-id="spotify-card" data-composition-src="compositions/spotify-card.html" data-start="0" data-duration="5" data-track-index="1" data-width="1080" data-height="1920"></div>
```
