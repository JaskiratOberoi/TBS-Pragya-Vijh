import Link from "next/link";
import { MessageCircle } from "lucide-react";

export function WhatsAppButton() {
  const phone = "919811611341";
  const text = encodeURIComponent("Hi, I have a question about The Blissful Soul.");
  return (
    <Link
      href={`https://wa.me/${phone}?text=${text}`}
      target="_blank"
      rel="noopener noreferrer"
      className="fixed bottom-6 right-6 z-50 flex h-14 w-14 items-center justify-center rounded-full bg-green-600 text-white shadow-lg transition hover:bg-green-700"
      aria-label="WhatsApp us"
    >
      <MessageCircle className="h-7 w-7" />
    </Link>
  );
}
