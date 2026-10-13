# Brief: photographer's portfolio

One of the four benchmark briefs. The builder gets this file verbatim and nothing else about the benchmark. See [../protocol.md](../protocol.md) for how it is used.

## Product
A one-page portfolio for **Mara Lindqvist**, a documentary and editorial photographer based in Glasgow. The page shows three bodies of work, says what she charges, and takes enquiries.

## Audience
Picture editors and commissioning editors at magazines and NGOs, checking a link on a laptop between meetings, and occasionally a private client on a phone looking for a day rate.

## The three tasks, in priority order
1. **View a body of work**: open one of the three projects and move through its photographs with their captions.
2. **Find the rates** for an editorial day and what the day includes.
3. **Send an enquiry**: name, email, the date you have in mind and a message, submitted to a confirmation.

## Constraints
- One `index.html` with `styles.css` and `app.js` beside it. No build step, no framework, no package install.
- No remote fonts, scripts, images or style sheets. Every request stays on the page's own origin.
- The enquiry submits locally: no network call. Show the confirmation on the same page.
- Photographs are described below. Draw each as a CSS or inline-SVG placeholder in the stated aspect ratio, with the description as `alt` or caption. Do not generate faces or imitate a real photograph.
- Must work from 320 px to 1440 px wide with no horizontal overflow, including with a project or lightbox open.
- Respect `prefers-reduced-motion`.

## Content pack
Use this copy as written. You may shorten a line or reorder, but do not invent projects, clients or prices beyond these.

**Name:** Mara Lindqvist
**One line:** Documentary and editorial photography. Glasgow, and wherever the story is.
**Statement:** I photograph people at work: night shifts, harvests, rehearsals, the hour before a shop opens. I stay long enough that nobody is posing. Commissions since 2016 for The Observer, Le Monde, Oxfam and the Scottish Fisheries Museum.

**Projects**

*1. Last Boat Out* (2023, 9 photographs). The final season of a Peterhead trawler crew before the boat was sold.
- Captions, in order: "Setting out, 04:10." "Deckhand Calum mending the net, day two." "Gutting room, three hours in." "The skipper's logbook." "Hail at the stern." "Sleeping quarters, four bunks." "Landing the catch at Peterhead." "The buyers' line." "The boat on the morning it was sold."

*2. Night Bakers* (2022, 7 photographs). Three bakeries in Glasgow, 23:00 to 06:00.
- Captions: "First dough, 23:40." "The proving room." "Scoring loaves at Dennistoun." "Tea break, 02:15." "The oven door." "Loading the van." "First customer, 06:05."

*3. Rehearsal Weeks* (2021, 8 photographs). The Citizens Theatre company preparing a new play.
- Captions: "Read-through, day one." "Blocking the second act." "Costume fitting." "Notes from the director." "Fight call." "The understudy's script." "Tech week, 01:00." "Opening night, from the wings."

**Rates**
| Service | Price | Includes |
| :--- | :--- | :--- |
| Editorial day | £650 | up to 8 hours, 40 edited photographs within 5 working days, single-use licence |
| Half day | £380 | up to 4 hours, 20 edited photographs within 5 working days |
| Long-form project | from £2,400 | a week or more on one story, licence agreed per project |
Travel outside Glasgow is charged at cost. Extended licences on request.

**Enquiry form fields:** Your name; Email; Date you have in mind; Message; button "Send enquiry".
**Form errors:** "Add your name." "Enter an email address." "Say a little about the job."
**Confirmation:** Thanks, [name]. I reply within two working days. If it is urgent, call 0141 000 0000.
**Footer:** Mara Lindqvist, Glasgow. Instagram. Prints. hello@maralindqvist.example

## Image descriptions
- Every photograph is a 3:2 landscape placeholder, dark grey, with its caption underneath, except "The skipper's logbook" and "The understudy's script", which are 2:3 portraits.
- **Portrait of Mara:** none. Use no image for the about section.
