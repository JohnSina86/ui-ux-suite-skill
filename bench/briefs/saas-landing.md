# Brief: SaaS landing page

One of the four benchmark briefs. The builder gets this file verbatim and nothing else about the benchmark. See [../protocol.md](../protocol.md) for how it is used.

## Product
**Ledgerline**, a B2B analytics tool that joins a company's billing, payroll and bank feeds into one cash-flow view, with alerts when a forecast line moves.

## Audience
Finance and operations leads at companies with 50 to 500 staff. They evaluate tools during a working day, often on a laptop, sometimes on a phone from a shared link. They are not designers and are tired of dashboards that promise "insights".

## The three tasks, in priority order
1. **Understand** what Ledgerline does and who it is for from the first screen, without scrolling.
2. **Start a free trial**: fill the form (name, work email, company size) and reach the confirmation.
3. **Find the price** for a team of 20 seats.

## Constraints
- One `index.html` with its CSS in a `styles.css` beside it; JavaScript only if needed, in `app.js`. No build step, no framework, no package install.
- No remote fonts, scripts, images or style sheets. Every request must stay on the page's own origin. Use the system font stack or a font you describe in CSS without loading one.
- The trial form submits locally: no network call. Show the confirmation on the same page.
- Image slots are described below. Render each as a placeholder you draw with CSS or inline SVG, labelled with its description in `alt` or a caption. No stock photos, no generated faces.
- Must work from 320 px to 1440 px wide with no horizontal overflow, with the mobile menu (if any) open or closed.
- Respect `prefers-reduced-motion`.

## Content pack
Use this copy as written. You may shorten a line, reorder sections or drop a section, but do not invent product claims, numbers or customers beyond these.

**Headline:** See next month's cash before it happens.

**Subhead:** Ledgerline joins your billing, payroll and bank feeds into one forecast, and tells you the day a line moves.

**Primary call to action:** Start a 14-day trial
**Secondary call to action:** See pricing

**Proof line:** Used by finance teams at 240 companies between 50 and 500 people.

**Section: how it works**
1. *Connect in an afternoon.* Read-only links to Stripe, Xero, QuickBooks, Gusto and your bank. Nothing is written back.
2. *One forecast, not twelve spreadsheets.* Every feed lands in the same 13-week view. Change a hiring date and the cash line moves with it.
3. *Alerts with the cause attached.* When a forecast line moves by more than your threshold, you get the line, the feed that moved it and the transaction behind it.

**Section: who it is for**
- Heads of finance who close the books themselves.
- Operations leads who own the hiring plan.
- Founders who still read the bank statement.

**Testimonial:** "We stopped rebuilding the forecast every Monday. The alerts caught a double-charged vendor in week two." Priya Natarajan, Head of Finance, Hollowell Logistics.

**Pricing** (per month, billed yearly; monthly billing adds 20%)
| Plan | Price | Seats | Includes |
| :--- | :--- | :--- | :--- |
| Starter | $90 | up to 5 | 3 feeds, 13-week forecast, email alerts |
| Team | $340 | up to 25 | unlimited feeds, scenario copies, Slack alerts, audit log |
| Company | talk to us | 25+ | SSO, custom thresholds, dedicated support |

**Trial form fields:** Full name; Work email; Company size (select: 1 to 49, 50 to 199, 200 to 500, 500+); button "Start trial".
**Form confirmation:** Check your inbox. We sent a sign-in link to [email]. It expires in 30 minutes.
**Form errors:** "Enter your name." "Enter a work email address." "Choose a company size."

**Footer:** Ledgerline Ltd. Privacy. Terms. Status. hello@ledgerline.example

## Image descriptions
- **Hero image:** a 13-week cash-flow chart with one line, a shaded confidence band, and a single alert marker on week 6 with the label "Payroll moved: +$18,400".
- **How-it-works image 1:** five small source logos (billing, accounting, payroll, two banks) joined by lines to one node.
- **How-it-works image 3:** an alert card: line name, delta, feed, transaction reference.
- **Testimonial image:** none. No portrait.
