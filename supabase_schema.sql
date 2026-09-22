-- ==============================================================================
-- LifeDrop (BLOOD-CONNECT) Supabase Database Schema & Setup Queries
-- Run these queries in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/btslkejjlolayjszuvtq/sql
-- ==============================================================================

-- 1. Create Donors Table
CREATE TABLE IF NOT EXISTS public.donors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    blood_group VARCHAR(5) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    city TEXT NOT NULL,
    area TEXT,
    last_donation_date DATE,
    is_verified BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Create SOS Emergency Requests Table
CREATE TABLE IF NOT EXISTS public.sos_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_name TEXT NOT NULL,
    blood_group VARCHAR(5) NOT NULL,
    units_needed INT DEFAULT 1,
    hospital TEXT NOT NULL,
    city TEXT,
    phone VARCHAR(20) NOT NULL,
    urgency TEXT DEFAULT 'Critical (Within 2 hrs)',
    status TEXT DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Create Blood Banks Table
CREATE TABLE IF NOT EXISTS public.blood_banks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    area TEXT,
    phone VARCHAR(20) NOT NULL,
    timing TEXT DEFAULT '24/7 Available',
    stock_status TEXT DEFAULT 'High Availability',
    is_verified BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. Enable Row Level Security (RLS) on all tables
ALTER TABLE public.donors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sos_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blood_banks ENABLE ROW LEVEL SECURITY;

-- 5. Drop existing policies if they exist to avoid duplicate conflicts
DROP POLICY IF EXISTS "Allow public read donors" ON public.donors;
DROP POLICY IF EXISTS "Allow public insert donors" ON public.donors;

DROP POLICY IF EXISTS "Allow public read sos_requests" ON public.sos_requests;
DROP POLICY IF EXISTS "Allow public insert sos_requests" ON public.sos_requests;

DROP POLICY IF EXISTS "Allow public read blood_banks" ON public.blood_banks;
DROP POLICY IF EXISTS "Allow public insert blood_banks" ON public.blood_banks;

-- 6. Create Public Access Policies (Allow read & insert for anon users)
CREATE POLICY "Allow public read donors" ON public.donors FOR SELECT USING (true);
CREATE POLICY "Allow public insert donors" ON public.donors FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow public read sos_requests" ON public.sos_requests FOR SELECT USING (true);
CREATE POLICY "Allow public insert sos_requests" ON public.sos_requests FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow public read blood_banks" ON public.blood_banks FOR SELECT USING (true);
CREATE POLICY "Allow public insert blood_banks" ON public.blood_banks FOR INSERT WITH CHECK (true);

-- 7. Insert Initial Seed Data
INSERT INTO public.donors (name, blood_group, phone, city, area, is_verified) VALUES
('Dr. Rahul Verma', 'O-', '+91 98765 43210', 'Bangalore', 'Indiranagar', true),
('Priya Sundaram', 'A+', '+91 98450 11223', 'Bangalore', 'Koramangala', true),
('Amitabh Sen', 'B+', '+91 97312 34567', 'Mumbai', 'Andheri West', true),
('Sneha Patel', 'O+', '+91 99201 88765', 'Mumbai', 'Bandra', true),
('Kavita Nair', 'AB+', '+91 94471 23456', 'Chennai', 'Adyar', true),
('Rajesh Khanna', 'AB-', '+91 98110 56789', 'Delhi', 'Connaught Place', true)
ON CONFLICT DO NOTHING;

INSERT INTO public.sos_requests (patient_name, blood_group, units_needed, hospital, city, phone, urgency) VALUES
('Deepak Sharma', 'O-', 2, 'Fortis Hospital, Cunningham Rd', 'Bangalore', '+91 98800 12345', 'Critical (Within 2 hrs)'),
('Ananya Gupta', 'AB-', 1, 'Max Super Speciality Hospital, Saket', 'Delhi', '+91 98101 23456', 'High (Within 6 hrs)'),
('Mohammed Rafi', 'B+', 3, 'Lilavati Hospital & Research Centre', 'Mumbai', '+91 98200 67890', 'Standard (Within 24 hrs)')
ON CONFLICT DO NOTHING;

INSERT INTO public.blood_banks (name, city, area, phone, timing, stock_status, is_verified) VALUES
('Red Cross Central Blood Bank', 'Bangalore', 'MG Road', '080-22264875', '24/7 Available', 'High Availability', true),
('Rashtrotthana Blood Centre', 'Bangalore', 'Gavipuram', '080-26612789', '24/7 Available', 'Moderate Stock', true),
('Tata Memorial Centre Blood Bank', 'Mumbai', 'Parel', '022-24177000', '24/7 Available', 'High Availability', true),
('Rotary Blood Bank', 'Delhi', 'Tughlakabad', '011-26052197', '24/7 Available', 'High Availability', true)
ON CONFLICT DO NOTHING;
