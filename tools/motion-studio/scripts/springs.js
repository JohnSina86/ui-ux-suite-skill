// Closed-form damped spring. Position at time t (seconds) for a move from 0 to 1, starting at rest.
// No integration steps, so any frame can be rendered on its own and the result is identical every run.
function spring(t, opts) {
  const o = Object.assign({ stiffness: 170, damping: 20, mass: 1 }, opts || {});
  if (t <= 0) return 0;
  const w0 = Math.sqrt(o.stiffness / o.mass);
  const zeta = o.damping / (2 * Math.sqrt(o.stiffness * o.mass));
  if (zeta < 1) {
    const wd = w0 * Math.sqrt(1 - zeta * zeta);
    return 1 - Math.exp(-zeta * w0 * t) * (Math.cos(wd * t) + ((zeta * w0) / wd) * Math.sin(wd * t));
  }
  if (zeta === 1) return 1 - Math.exp(-w0 * t) * (1 + w0 * t);
  const s = w0 * Math.sqrt(zeta * zeta - 1);
  const r1 = -zeta * w0 + s;
  const r2 = -zeta * w0 - s;
  return 1 - (r2 * Math.exp(r1 * t) - r1 * Math.exp(r2 * t)) / (r2 - r1);
}
// Map a spring onto any range: lerp(from, to, spring(t - delay, opts)).
function springTo(from, to, t, delay, opts) {
  return from + (to - from) * spring(t - (delay || 0), opts);
}
if (typeof window !== "undefined") { window.spring = spring; window.springTo = springTo; }
if (typeof module !== "undefined") { module.exports = { spring, springTo }; }
