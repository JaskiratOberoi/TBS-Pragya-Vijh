function formatIcsDate(d: Date) {
  return d.toISOString().replace(/[-:]/g, "").split(".")[0] + "Z";
}

export function buildBookingIcs(opts: {
  title: string;
  description: string;
  start: Date;
  end: Date;
  uid: string;
}) {
  const lines = [
    "BEGIN:VCALENDAR",
    "VERSION:2.0",
    "PRODID:-//The Blissful Soul//Booking//EN",
    "BEGIN:VEVENT",
    `UID:${opts.uid}`,
    `DTSTAMP:${formatIcsDate(new Date())}`,
    `DTSTART:${formatIcsDate(opts.start)}`,
    `DTEND:${formatIcsDate(opts.end)}`,
    `SUMMARY:${opts.title.replace(/\n/g, " ")}`,
    `DESCRIPTION:${opts.description.replace(/\n/g, "\\n")}`,
    "END:VEVENT",
    "END:VCALENDAR",
  ];
  return lines.join("\r\n");
}
