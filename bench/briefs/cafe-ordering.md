# Brief: café menu and order

One of the four benchmark briefs. The builder gets this file verbatim and nothing else about the benchmark. See [../protocol.md](../protocol.md) for how it is used.

## Product
**Kettle & Crumb**, a neighbourhood café. A mobile-first page where a customer reads the menu, builds an order and places it for collection at the counter.

## Audience
Regulars and passers-by ordering on a phone, often one-handed while walking or queuing. Some order every morning and want the same thing in three taps. Some have an allergy and need the information before they order.

## The three tasks, in priority order
1. **Browse the menu** by category and open one item to read its description and allergens.
2. **Build an order**: add two different items, change one quantity, and see the total update.
3. **Place the order** for collection: give a name and a collection time, submit, and reach the confirmation.

## Constraints
- One `index.html` with `styles.css` and `app.js` beside it. No build step, no framework, no package install.
- No remote fonts, scripts, images or style sheets. Every request stays on the page's own origin.
- The order is held in the page and the submit is local: no network call. Show the confirmation on the same page.
- Image slots are described below. Draw each as a CSS or inline-SVG placeholder with its description as `alt` or a caption. No stock photos.
- Phone first. Must work from 320 px to 1440 px wide with no horizontal overflow, including with the order panel, an item's detail view, or any menu open.
- Respect `prefers-reduced-motion`.

## Content pack
Use this copy as written. You may shorten a line or reorder, but do not invent items, prices or allergens beyond these.

**Name:** Kettle & Crumb
**Line under the name:** Collection orders, ready in 10 minutes. Counter at 14 Orchard Lane.
**Opening line:** Open 7:00 to 16:00, Monday to Saturday.

**Menu**

*Coffee*
| Item | Price | Description | Allergens |
| :--- | :--- | :--- | :--- |
| Flat white | £3.40 | Double shot, steamed whole milk, 180 ml. | Milk |
| Oat latte | £3.80 | Double shot, oat milk, 300 ml. | Oats (gluten) |
| Batch filter | £2.80 | Today: Gakuyuini, Kenya. Black, 300 ml. | None |
| Espresso | £2.40 | Double shot. | None |

*Food*
| Item | Price | Description | Allergens |
| :--- | :--- | :--- | :--- |
| Sourdough toast with butter and jam | £4.20 | Two slices, salted butter, damson jam. | Gluten, milk |
| Cheese and pickle toastie | £6.50 | Mature cheddar, Branston pickle, sourdough. | Gluten, milk |
| Granola bowl | £5.90 | House granola, yoghurt, poached rhubarb. | Oats (gluten), milk, nuts |
| Cinnamon bun | £3.60 | Baked at 6:30 each morning. | Gluten, milk, egg |

*Cold drinks*
| Item | Price | Description | Allergens |
| :--- | :--- | :--- | :--- |
| Cold brew | £3.60 | 18-hour steep, over ice, 350 ml. | None |
| Apple juice | £2.90 | Pressed in Herefordshire, 250 ml. | None |

**Order panel labels:** Your order; Add; Remove; Quantity; Total; Collect this order.
**Empty order:** Nothing added yet. Pick something from the menu.
**Collection form fields:** Name for the order; Collection time (select: As soon as possible, 10 minutes, 20 minutes, 30 minutes); button "Place order".
**Form errors:** "Add a name so we can call it out." "Choose a collection time."
**Confirmation:** Thanks, [name]. Order [number] will be on the counter at [time]. Show this screen when you collect it.
**Allergen note:** Everything is made in one kitchen that handles nuts, gluten, milk and egg. Ask at the counter if you need more detail.

## Image descriptions
- **Header image:** the counter from the customer's side: a wooden counter, a brass kettle, a tray of cinnamon buns, morning light from the left.
- **Item images:** one square placeholder per item, labelled with the item name. No photos of people.
