"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export function FooterNewsletter() {
  return (
    <div className="mt-6">
      <p className="text-xs font-medium uppercase tracking-luxury text-metal">Newsletter</p>
      <p className="mt-1 text-sm text-inverse-muted">Occasional drops and session openings.</p>
      <form
        className="mt-4 flex flex-col gap-2 sm:flex-row"
        onSubmit={(e) => e.preventDefault()}
      >
        <Input
          type="email"
          placeholder="Your email"
          className="rounded-full border-inverse-muted/30 bg-inverse-foreground/5 text-inverse-foreground placeholder:text-inverse-muted"
          aria-label="Email for newsletter"
        />
        <Button
          type="button"
          variant="secondary"
          className="rounded-full bg-metal text-metal-foreground hover:bg-metal/90"
        >
          Join
        </Button>
      </form>
    </div>
  );
}
