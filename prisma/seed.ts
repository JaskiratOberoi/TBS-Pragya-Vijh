import { readFileSync } from "fs";
import { join } from "path";
import { PrismaClient, ProductType, ServiceType, PromoRuleType } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

const PRODUCT_IMAGE_URLS = JSON.parse(
  readFileSync(join(process.cwd(), "prisma/data/product-image-urls.json"), "utf8")
) as Record<string, string[]>;

function productImages(slug: string): string[] {
  return PRODUCT_IMAGE_URLS[slug] ?? ["/assets/products/placeholder.svg"];
}

function rupeeToPaise(r: number) {
  return Math.round(r * 100);
}

async function main() {
  const passwordHash = await bcrypt.hash("ChangeMe123!", 12);

  await prisma.user.upsert({
    where: { email: "admin@theblissfulsoul.com" },
    update: {},
    create: {
      email: "admin@theblissfulsoul.com",
      name: "Admin",
      passwordHash,
      role: "ADMIN",
      phone: "+919811611341",
    },
  });

  const shipFree = await prisma.shippingClass.upsert({
    where: { id: "ship-free" },
    update: {},
    create: {
      id: "ship-free",
      name: "Standard (Free)",
      rate: 0,
      freeAbove: null,
      description: "Free shipping",
    },
  });

  const shipPaid = await prisma.shippingClass.upsert({
    where: { id: "ship-paid" },
    update: {},
    create: {
      id: "ship-paid",
      name: "Standard (Paid)",
      rate: rupeeToPaise(99),
      freeAbove: rupeeToPaise(1500),
      description: "Flat rate under order value",
    },
  });

  const catBracelet = await prisma.productCategory.upsert({
    where: { slug: "bracelet" },
    update: {},
    create: { name: "Bracelet", slug: "bracelet", sortOrder: 1 },
  });
  const catTumbles = await prisma.productCategory.upsert({
    where: { slug: "tumbles" },
    update: {},
    create: { name: "Tumbles", slug: "tumbles", sortOrder: 2 },
  });
  const catPyramid = await prisma.productCategory.upsert({
    where: { slug: "pyramid" },
    update: {},
    create: { name: "Pyramid", slug: "pyramid", sortOrder: 3 },
  });
  const catLocket = await prisma.productCategory.upsert({
    where: { slug: "locket" },
    update: {},
    create: { name: "Locket", slug: "locket", sortOrder: 4 },
  });
  const catCombo = await prisma.productCategory.upsert({
    where: { slug: "combo" },
    update: {},
    create: { name: "Combo", slug: "combo", sortOrder: 5 },
  });
  const catOther = await prisma.productCategory.upsert({
    where: { slug: "other" },
    update: {},
    create: { name: "Other", slug: "other", sortOrder: 6 },
  });

  const products: Array<{
    slug: string;
    name: string;
    categoryId: string;
    price: number;
    salePrice?: number;
    stock: number;
    type?: ProductType;
  }> = [
    { slug: "money-pyramid-selenite-charging-plate-combo", name: "Money Pyramid & Selenite Plate Combo", categoryId: catCombo.id, price: 5999, salePrice: 1919, stock: 50 },
    { slug: "pyrite-money-keychain-1-piece-assorted", name: "Pyrite Money Keychain (1 pc)", categoryId: catOther.id, price: 999, salePrice: 459, stock: 100 },
    { slug: "money-pyramid", name: "Money Pyramid", categoryId: catPyramid.id, price: 1999, salePrice: 999, stock: 80 },
    { slug: "amethyst-natural-bracelet", name: "Amethyst Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 999, stock: 60 },
    { slug: "rose-quartz-natural-bracelet", name: "Rose Quartz Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 999, stock: 60 },
    { slug: "money-magnet", name: "Money Magnet", categoryId: catBracelet.id, price: 1999, salePrice: 999, stock: 100 },
    { slug: "crystal-charger-selenite-plate", name: "Crystal Charger – Selenite Plate", categoryId: catOther.id, price: 1999, salePrice: 599, stock: 40 },
    { slug: "rose-quartz-pyramid", name: "Rose Quartz Pyramid", categoryId: catPyramid.id, price: 1999, salePrice: 999, stock: 45 },
    { slug: "black-obsidian-tumbles-negativity-evil-eye", name: "Black Obsidian Tumbles", categoryId: catTumbles.id, price: 999, salePrice: 299, stock: 120 },
    { slug: "amethyst-tumbles-peace-and-anxiety", name: "Amethyst Tumbles", categoryId: catTumbles.id, price: 999, salePrice: 299, stock: 120 },
    { slug: "rose-quartz-tumbles-love-relationships", name: "Rose Quartz Tumbles", categoryId: catTumbles.id, price: 999, salePrice: 299, stock: 120 },
    { slug: "riche-rich", name: "Riche Rich", categoryId: catBracelet.id, price: 1999, salePrice: 1499, stock: 30 },
    { slug: "pyrite-natural-bracelet", name: "Pyrite Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 1499, stock: 35 },
    { slug: "sage-sticks-negativity-removal", name: "Sage Sticks", categoryId: catOther.id, price: 999, salePrice: 499, stock: 200 },
    { slug: "masters-wish-box-manifest-all-desires", name: "Master's Wish Box", categoryId: catOther.id, price: 2499, salePrice: 1499, stock: 25 },
    { slug: "genie-bracelet", name: "Genie Bracelet", categoryId: catBracelet.id, price: 999, salePrice: 499, stock: 90 },
    { slug: "rose-quartz-pencil-locketself-love-and-relationship", name: "Rose Quartz Pencil Locket", categoryId: catLocket.id, price: 1999, salePrice: 699, stock: 40 },
    { slug: "red-jasper-natural-bracelet", name: "Red Jasper Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 1499, stock: 40 },
    { slug: "pregnancy-health-bracelet", name: "Pregnancy & Health Bracelet", categoryId: catBracelet.id, price: 1499, stock: 20 },
    { slug: "black-obsidian-pencil-locketevil-eye-and-nazar", name: "Black Obsidian Pencil Locket", categoryId: catLocket.id, price: 1999, salePrice: 699, stock: 40 },
    { slug: "black-obsidian-natural-bracelet", name: "Black Obsidian Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 1499, stock: 50 },
    { slug: "7-chakra-locketoverall-health", name: "7 Chakra Locket", categoryId: catLocket.id, price: 1999, salePrice: 1199, stock: 35 },
    { slug: "black-obsidian-pyramid", name: "Black Obsidian Pyramid", categoryId: catPyramid.id, price: 1999, salePrice: 999, stock: 40 },
    { slug: "healing-sea-salt", name: "Healing sea salt", categoryId: catOther.id, price: 777, salePrice: 299, stock: 150 },
    { slug: "tiger-eye-locketself-esteem-and-confidence", name: "Tiger Eye Locket", categoryId: catLocket.id, price: 1999, salePrice: 1199, stock: 30 },
    { slug: "tiger-eye-natural-bracelet", name: "Tiger Eye Natural Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 1279, stock: 35 },
    { slug: "citrine-braceletmoney-and-growth", name: "Citrine Bracelet", categoryId: catBracelet.id, price: 1999, salePrice: 1419, stock: 40 },
  ];

  for (const p of products) {
    await prisma.product.upsert({
      where: { slug: p.slug },
      update: {
        name: p.name,
        price: rupeeToPaise(p.price),
        salePrice: p.salePrice != null ? rupeeToPaise(p.salePrice) : null,
        stock: p.stock,
        images: productImages(p.slug),
      },
      create: {
        slug: p.slug,
        name: p.name,
        description: `Healing crystal product: ${p.name}. From The Blissful Soul.`,
        categoryId: p.categoryId,
        productType: p.type ?? "PHYSICAL",
        price: rupeeToPaise(p.price),
        salePrice: p.salePrice != null ? rupeeToPaise(p.salePrice) : null,
        stock: p.stock,
        images: productImages(p.slug),
        shippingClassId: shipFree.id,
        hsnCode: "7117",
        gstRateBps: 300,
        isActive: true,
      },
    });
  }

  const services = [
    { name: "Tarot Reading", type: ServiceType.AUDIO, price: 999, duration: 20 },
    { name: "Tarot Reading", type: ServiceType.AUDIO, price: 1499, duration: 30 },
    { name: "Kundali Session", type: ServiceType.AUDIO, price: 1499, duration: 30 },
    { name: "Therapy & Counselling Sessions", type: ServiceType.AUDIO, price: 999, duration: 35 },
    { name: "All-in-1 Astrology", type: ServiceType.AUDIO, price: 3499, duration: 40 },
    { name: "Tarot Reading", type: ServiceType.VIDEO, price: 2500, duration: 30 },
    { name: "Kundali Session", type: ServiceType.VIDEO, price: 2500, duration: 30 },
    { name: "Therapy & Counselling Sessions", type: ServiceType.VIDEO, price: 1299, duration: 40 },
    { name: "All-in-1 Astrology", type: ServiceType.VIDEO, price: 4499, duration: 40 },
  ];

  await prisma.service.deleteMany({});
  for (const s of services) {
    await prisma.service.create({
      data: {
        name: s.name,
        type: s.type,
        price: rupeeToPaise(s.price),
        durationMinutes: s.duration,
        bufferMinutes: 10,
        isActive: true,
        description: `${s.name} — ${s.type} session`,
      },
    });
  }

  await prisma.testimonial.deleteMany({});
  const testimonials = [
    {
      name: "Tripti Jain",
      text: "Vastu healing karwayi thi mam se aur uske baad mere ghar mein bohut changes hone lage hai. Thank you Pragya mam mere life se problems dur karne ke liye",
    },
    {
      name: "Sukh Kaur",
      text: "I just had a really enlightening session with Pragya regarding my personal life. I must say it was a pleasure to talk to her and receive guidance. The solutions she gave were very simple and effective. Loved my time with her.",
    },
    { name: "Ruhi Verma", text: "The prediction done by Master Pragya was so appropriate that I was shocked." },
    { name: "Rohit Bagga", text: "Thank you so much Pragya Mam. The ritual worked like magic for me." },
    { name: "Aashita Pandey", text: "It was a great Tarot session that I had with Ma'am today." },
    { name: "Taruna Goyal", text: "I am very thankful to Master Pragya for all the guidance that she gave me." },
  ];
  let sort = 0;
  for (const t of testimonials) {
    await prisma.testimonial.create({ data: { ...t, sortOrder: sort++ } });
  }

  await prisma.product.upsert({
    where: { slug: "money-potli-gift" },
    update: { name: "Money Potli (Gift)", images: productImages("money-potli-gift") },
    create: {
      slug: "money-potli-gift",
      name: "Money Potli (Gift)",
      description: "Complimentary gift on qualifying orders.",
      categoryId: catOther.id,
      productType: "PHYSICAL",
      price: 0,
      salePrice: null,
      stock: 9999,
      images: productImages("money-potli-gift"),
      shippingClassId: shipFree.id,
      hsnCode: "7117",
      gstRateBps: 300,
      isActive: true,
    },
  });

  await prisma.promoRule.deleteMany({});
  await prisma.promoRule.createMany({
    data: [
      { type: PromoRuleType.BUY_X_GET_Y, config: { buy: 3, get: 1, scope: "line_items" }, isActive: true },
      {
        type: PromoRuleType.FREE_GIFT_THRESHOLD,
        config: { thresholdPaise: rupeeToPaise(1499), giftProductSlug: "money-potli-gift" },
        isActive: true,
      },
    ],
  });

  await prisma.bookingSettings.upsert({
    where: { id: "singleton" },
    update: {},
    create: {
      id: "singleton",
      slotDurationMinutes: 30,
      bufferBetweenSlots: 15,
      maxAdvanceBookingDays: 60,
      minAdvanceBookingHours: 2,
      cancellationPolicyHours: 24,
      gcalSyncEnabled: false,
      autoConfirm: true,
    },
  });

  await prisma.businessSettings.upsert({
    where: { id: "singleton" },
    update: {},
    create: {
      id: "singleton",
      businessName: "The Blissful Soul",
      gstin: "",
      pan: "",
      address: "Shakti Nagar, Delhi 110007",
      state: "Delhi",
      stateCode: "07",
      phone: "+919811611341",
      email: "theblissfulsoul27@gmail.com",
      invoicePrefix: "TBS",
      nextInvoiceNumber: 1,
    },
  });

  const legal = [
    { slug: "terms", title: "Terms and Conditions", content: "<p>Placeholder terms. Replace in admin.</p>" },
    { slug: "refund-policy", title: "Refund Policy", content: "<p>Placeholder refund policy.</p>" },
    { slug: "privacy-policy", title: "Privacy Policy", content: "<p>Placeholder privacy policy.</p>" },
    { slug: "shipping-policy", title: "Shipping Policy", content: "<p>Placeholder shipping policy.</p>" },
  ];
  for (const l of legal) {
    await prisma.legalPage.upsert({
      where: { slug: l.slug },
      update: {},
      create: l,
    });
  }

  // Weekly availability Mon-Fri 10-18
  await prisma.availabilityRule.deleteMany({});
  for (let d = 1; d <= 5; d++) {
    await prisma.availabilityRule.create({
      data: { dayOfWeek: d, startTime: "10:00", endTime: "18:00", isActive: true },
    });
  }

  console.log("Seed complete. Admin: admin@theblissfulsoul.com / ChangeMe123!");
}

main()
  .then(() => prisma.$disconnect())
  .catch((e) => {
    console.error(e);
    prisma.$disconnect();
    process.exit(1);
  });
