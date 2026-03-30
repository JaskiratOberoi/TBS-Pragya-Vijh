/**
 * Fixed, non-interactive layer behind page content. Pure markup + CSS (no client JS).
 * Paused when prefers-reduced-motion is set.
 */
export function AmbientBackdrop() {
  return (
    <div className="pointer-events-none fixed inset-0 z-0 overflow-hidden" aria-hidden>
      <div className="ambient-orb ambient-orb-a" />
      <div className="ambient-orb ambient-orb-b" />
      <div className="ambient-orb ambient-orb-c" />
      <div className="ambient-grid-fade" />
      <div className="ambient-noise" />
    </div>
  );
}
