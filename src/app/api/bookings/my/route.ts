import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const bookings = await prisma.booking.findMany({
    where: { userId: session.user.id },
    orderBy: { scheduledAt: "desc" },
    include: { service: true },
    take: 50,
  });
  return NextResponse.json({
    bookings: bookings.map((b) => ({
      id: b.id,
      status: b.status,
      paymentStatus: b.paymentStatus,
      scheduledAt: b.scheduledAt,
      endAt: b.endAt,
      service: { name: b.service.name, type: b.service.type },
      amountPaid: b.amountPaid,
    })),
  });
}
