# Chess Arena Online — setup

## 1. Configure Supabase

1. Open your Supabase project.
2. Open **SQL Editor** and create a new query.
3. Copy and run the complete contents of [supabase/schema.sql](supabase/schema.sql).
4. In **Project Settings → API Keys**, copy the **Project URL** and the **Publishable key** (often starts with `sb_publishable_`). Never use or share a `service_role` or secret key in the browser.

## 2. Open the app

Open `index.html` in a browser for a local preview, or deploy the repository with Cloudflare Pages:
- Connect the GitHub repository `MuhammedNime/chess-arena-online`.
- Framework preset: **None**.
- Build command: leave blank.
- Build output directory: `/` (the repository root).
- Deploy, then open the provided `.pages.dev` URL.

In the app, select **Settings**, paste the Supabase Project URL and Publishable key, then select **Save connection**.

## 3. Test two-device play

1. On device A, create an invite room and copy the link.
2. Open that link on device B (or use **Join room from link**) after saving the same Supabase settings on device B.
3. Make moves on each side and confirm that the board updates on both devices.

## Prototype limitations

This is an early MVP, not yet a production-ready Chess.com replacement. The browser app includes a chess board, legal move validation, move history, clocks, and a Supabase Realtime room prototype. The current SQL policies deliberately allow any client with the public key to read/update room rows; room IDs are not an authentication system. Before public launch, implement authenticated room membership and server-side validation/rate limits. Clock values are currently local and are not authoritative synchronized clocks. Promotion currently defaults to a queen. Test all features before inviting others.
