import { cn } from "@/lib/utils";

type SpinnerSize = "sm" | "md" | "lg";

const sizeClass: Record<SpinnerSize, string> = {
  sm: "h-5 w-5 border-2",
  md: "h-8 w-8 border-[3px]",
  lg: "h-12 w-12 border-4",
};

/**
 * CSS ring spinner (no SVG) so it always paints even if icon fonts fail.
 */
export function LoadingSpinner({
  className,
  size = "md",
}: {
  className?: string;
  size?: SpinnerSize;
}) {
  return (
    <div
      className={cn(
        "shrink-0 animate-spin rounded-full border-muted-foreground/25 border-t-primary",
        sizeClass[size],
        className
      )}
      role="presentation"
      aria-hidden
    />
  );
}

/** Full-width loading area for route transitions and Suspense fallbacks. */
export function LoadingScreen({ label = "Loading" }: { label?: string }) {
  return (
    <div
      className="flex min-h-[40vh] flex-col items-center justify-center gap-3"
      role="status"
      aria-live="polite"
      aria-busy="true"
    >
      <LoadingSpinner size="lg" />
      <span className="sr-only">{label}</span>
    </div>
  );
}
