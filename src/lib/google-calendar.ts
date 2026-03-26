/** Google Calendar integration — connect OAuth in admin; optional at runtime. */

export async function fetchBusySlots(_calendarId: string, _date: Date): Promise<{ start: Date; end: Date }[]> {
  return [];
}

export async function createBookingEvent(
  _calendarId: string,
  _payload: { title: string; description: string; start: Date; end: Date; attendeeEmail?: string }
): Promise<string | null> {
  return null;
}

export async function deleteBookingEvent(_calendarId: string, _eventId: string) {
  return;
}

export async function updateBookingEvent(
  _calendarId: string,
  _eventId: string,
  _updates: { start?: Date; end?: Date }
) {
  return;
}
