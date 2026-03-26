import Link from "next/link";

export function Footer() {
  return (
    <footer className="border-t bg-secondary/30">
      <div className="mx-auto grid max-w-7xl gap-8 px-4 py-12 md:grid-cols-3">
        <div>
          <h3 className="font-semibold text-primary">Contact us</h3>
          <ul className="mt-3 space-y-2 text-sm text-muted-foreground">
            <li>The Blissful Soul, Shakti Nagar, Delhi 110007</li>
            <li>Phone: +91 98116 11341</li>
            <li>Email: theblissfulsoul27@gmail.com</li>
          </ul>
        </div>
        <div>
          <h3 className="font-semibold text-primary">Quick links</h3>
          <ul className="mt-3 space-y-2 text-sm">
            <li>
              <Link href="/about" className="text-muted-foreground hover:text-foreground">
                About Master
              </Link>
            </li>
            <li>
              <Link href="/services" className="text-muted-foreground hover:text-foreground">
                Book your service
              </Link>
            </li>
            <li>
              <Link href="/shop" className="text-muted-foreground hover:text-foreground">
                Shop now
              </Link>
            </li>
          </ul>
        </div>
        <div>
          <h3 className="font-semibold text-primary">Legal</h3>
          <ul className="mt-3 space-y-2 text-sm">
            <li>
              <Link href="/terms" className="text-muted-foreground hover:text-foreground">
                Terms
              </Link>
            </li>
            <li>
              <Link href="/privacy-policy" className="text-muted-foreground hover:text-foreground">
                Privacy
              </Link>
            </li>
            <li>
              <Link href="/refund-policy" className="text-muted-foreground hover:text-foreground">
                Refund policy
              </Link>
            </li>
            <li>
              <Link href="/shipping-policy" className="text-muted-foreground hover:text-foreground">
                Shipping policy
              </Link>
            </li>
          </ul>
        </div>
      </div>
      <div className="border-t py-4 text-center text-xs text-muted-foreground">
        © {new Date().getFullYear()} The Blissful Soul
      </div>
    </footer>
  );
}
