CREATE TABLE "account" (
    "user_id" SERIAL NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "password" VARCHAR(60) NOT NULL,
    "is_admin" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id")
);
CREATE TABLE "event" (
    "event_id" SERIAL NOT NULL,
    "website_id" INTEGER NOT NULL,
    "session_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "url" VARCHAR(500) NOT NULL,
    "event_type" VARCHAR(50) NOT NULL,
    "event_value" VARCHAR(50) NOT NULL,
    PRIMARY KEY ("event_id")
);
CREATE TABLE "pageview" (
    "view_id" SERIAL NOT NULL,
    "website_id" INTEGER NOT NULL,
    "session_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "url" VARCHAR(500) NOT NULL,
    "referrer" VARCHAR(500),
    PRIMARY KEY ("view_id")
);
CREATE TABLE "session" (
    "session_id" SERIAL NOT NULL,
    "session_uuid" UUID NOT NULL,
    "website_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "hostname" VARCHAR(100),
    "browser" VARCHAR(20),
    "os" VARCHAR(20),
    "device" VARCHAR(20),
    "screen" VARCHAR(11),
    "language" VARCHAR(35),
    "country" CHAR(2),
    PRIMARY KEY ("session_id")
);
CREATE TABLE "website" (
    "website_id" SERIAL NOT NULL,
    "website_uuid" UUID NOT NULL,
    "user_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "domain" VARCHAR(500),
    "share_id" VARCHAR(64),
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("website_id")
);
CREATE UNIQUE INDEX "account.username_unique" ON "account"("username");
CREATE INDEX "event_created_at_idx" ON "event"("created_at");
CREATE INDEX "event_session_id_idx" ON "event"("session_id");
CREATE INDEX "event_website_id_idx" ON "event"("website_id");
CREATE INDEX "pageview_created_at_idx" ON "pageview"("created_at");
CREATE INDEX "pageview_session_id_idx" ON "pageview"("session_id");
CREATE INDEX "pageview_website_id_created_at_idx" ON "pageview"("website_id", "created_at");
CREATE INDEX "pageview_website_id_idx" ON "pageview"("website_id");
CREATE INDEX "pageview_website_id_session_id_created_at_idx" ON "pageview"("website_id", "session_id", "created_at");
CREATE UNIQUE INDEX "session.session_uuid_unique" ON "session"("session_uuid");
CREATE INDEX "session_created_at_idx" ON "session"("created_at");
CREATE INDEX "session_website_id_idx" ON "session"("website_id");
CREATE UNIQUE INDEX "website.website_uuid_unique" ON "website"("website_uuid");
CREATE UNIQUE INDEX "website.share_id_unique" ON "website"("share_id");
CREATE INDEX "website_user_id_idx" ON "website"("user_id");
ALTER TABLE "event" ADD FOREIGN KEY ("session_id") REFERENCES "session"("session_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "event" ADD FOREIGN KEY ("website_id") REFERENCES "website"("website_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "pageview" ADD FOREIGN KEY ("session_id") REFERENCES "session"("session_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "pageview" ADD FOREIGN KEY ("website_id") REFERENCES "website"("website_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "session" ADD FOREIGN KEY ("website_id") REFERENCES "website"("website_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "website" ADD FOREIGN KEY ("user_id") REFERENCES "account"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;
INSERT INTO account (username, password, is_admin) values ('admin', '$2b$10$BUli0c.muyCW1ErNJc3jL.vFRFtFJWrT8/GcR4A.sUdCznaXiqFXa', true);

