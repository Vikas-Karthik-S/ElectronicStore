-- Create Database
CREATE DATABASE IF NOT EXISTS electronic_store;
USE electronic_store;

-- 1. Users Table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Address Table
CREATE TABLE Address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- 3. Categories Table
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    image_url VARCHAR(255)
);

-- 4. Products Table
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
);

-- 5. Product Specifications Table
CREATE TABLE Product_Specifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    spec_name VARCHAR(100) NOT NULL,
    spec_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- 6. Cart Table
CREATE TABLE Cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- 7. Cart Items Table
CREATE TABLE Cart_Items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES Cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- 8. Orders Table
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    shipping_address TEXT NOT NULL,
    stock_restored BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- 9. Order Items Table
CREATE TABLE Order_Items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- Data Insertion
-- Insert 12 Categories
INSERT INTO Categories (id, name, description, image_url) VALUES
(1, 'Mobiles', 'Latest smartphones from top brands', 'mobiles.jpg'),
(2, 'Laptops', 'High-performance laptops and ultrabooks', 'laptops.jpg'),
(3, 'Tablets', 'Portable and powerful tablets', 'tablets.jpg'),
(4, 'Smartwatches', 'Smart wearables for your wrist', 'smartwatches.jpg'),
(5, 'Headphones', 'Immersive audio equipment', 'headphones.jpg'),
(6, 'Cameras', 'Professional cameras and accessories', 'cameras.jpg'),
(7, 'Televisions', 'Smart TVs and home theater systems', 'tvs.jpg'),
(8, 'Gaming Consoles', 'Next-gen gaming systems', 'gaming.jpg'),
(9, 'Printers', 'Reliable printers and scanners', 'printers.jpg'),
(10, 'Accessories', 'Cables, chargers, and cases', 'accessories.jpg'),
(11, 'Monitors', 'High-resolution displays', 'monitors.jpg'),
(12, 'Storage Devices', 'Hard drives and SSDs', 'storage.jpg');

-- Insert Products with Adjusted INR Prices (Price * 80 rounded - 1)
INSERT INTO Products (id, category_id, name, brand, price, description, stock, image_url) VALUES
(1, 1, 'iPhone 15 Pro', 'Apple', 79919.00, 'Titanium design, A17 Pro chip', 50, 'iphone15pro.jpg'),
(2, 1, 'Galaxy S24 Ultra', 'Samsung', 95919.00, 'AI powered camera, Snapdragon 8 Gen 3', 45, 's24ultra.jpg'),
(3, 1, 'Pixel 8 Pro', 'Google', 71919.00, 'The best of Google AI', 30, 'pixel8pro.jpg'),
(4, 1, 'OnePlus 12', 'OnePlus', 63919.00, 'Fast and smooth performance', 40, 'oneplus12.jpg'),
(5, 1, 'Xiaomi 14 Ultra', 'Xiaomi', 87919.00, 'Leica optics professional camera', 20, 'xiaomi14ultra.jpg'),
(6, 2, 'MacBook Air M3', 'Apple', 87919.00, 'Thin, light, and powerful', 60, 'macbookairm3.jpg'),
(7, 2, 'Dell XPS 13', 'Dell', 103919.00, 'InfinityEdge display, premium design', 35, 'dellxps13.jpg'),
(8, 2, 'HP Spectre x360', 'HP', 111919.00, 'Versatile 2-in-1 laptop', 25, 'hpspectre.jpg'),
(9, 2, 'Lenovo ThinkPad X1 Carbon', 'Lenovo', 127919.00, 'The ultimate business laptop', 20, 'thinkpad.jpg'),
(10, 2, 'Asus ROG Zephyrus G14', 'Asus', 119919.00, 'Powerful gaming laptop', 15, 'rogzephyrus.jpg'),
(11, 3, 'iPad Pro 12.9', 'Apple', 87919.00, 'Liquid Retina XDR display', 40, 'ipadpro.jpg'),
(12, 3, 'Galaxy Tab S9 Ultra', 'Samsung', 79919.00, 'Massive AMOLED screen', 30, 'tabs9ultra.jpg'),
(13, 3, 'Surface Pro 9', 'Microsoft', 71919.00, 'Tablet meets laptop', 25, 'surfacepro9.jpg'),
(14, 3, 'iPad Air', 'Apple', 47919.00, 'Powerful M1 chip', 50, 'ipadair.jpg'),
(15, 3, 'Lenovo Tab P12 Pro', 'Lenovo', 55919.00, 'Premium Android tablet', 20, 'lenovotab.jpg'),
(16, 4, 'Apple Watch Series 9', 'Apple', 31919.00, 'Smarter and more powerful', 100, 'applewatch9.jpg'),
(17, 4, 'Galaxy Watch 6 Classic', 'Samsung', 27919.00, 'Rotating bezel returns', 80, 'galaxywatch6.jpg'),
(18, 4, 'Garmin Fenix 7', 'Garmin', 55919.00, 'Ultimate multisport GPS watch', 40, 'garminfenix7.jpg'),
(19, 4, 'Pixel Watch 2', 'Google', 27919.00, 'Advanced health and fitness', 60, 'pixelwatch2.jpg'),
(20, 4, 'Amazfit GTR 4', 'Amazfit', 15919.00, 'Long battery life', 120, 'amazfitgtr4.jpg'),
(21, 5, 'Sony WH-1000XM5', 'Sony', 31919.00, 'Industry leading noise canceling', 50, 'sonywh1000xm5.jpg'),
(22, 5, 'Bose QuietComfort Ultra', 'Bose', 34319.00, 'Immersive spatial audio', 45, 'boseqc.jpg'),
(23, 5, 'AirPods Pro 2', 'Apple', 19919.00, 'Enhanced noise cancellation', 150, 'airpodspro.jpg'),
(24, 5, 'Sennheiser Momentum 4', 'Sennheiser', 27919.00, 'Superior sound quality', 30, 'sennheiser.jpg'),
(25, 5, 'Beats Studio Pro', 'Beats', 27919.00, 'Iconic sound and design', 60, 'beatstudio.jpg'),
(26, 6, 'Sony A7 IV', 'Sony', 199919.00, 'Hybrid full-frame mirrorless', 15, 'sonya7iv.jpg'),
(27, 6, 'Canon EOS R6 Mark II', 'Canon', 183919.00, 'High-speed performance', 12, 'canoneosr6.jpg'),
(28, 6, 'Fujifilm X-T5', 'Fujifilm', 135919.00, 'Vintage design, modern tech', 10, 'fujifilmxt5.jpg'),
(29, 6, 'GoPro Hero 12', 'GoPro', 31919.00, 'The ultimate action camera', 40, 'gopro12.jpg'),
(30, 6, 'Nikon Z8', 'Nikon', 295919.00, 'Pro-level performance', 8, 'nikonz8.jpg'),
(31, 7, 'LG C3 OLED', 'LG', 143919.00, 'Infinite contrast, perfect blacks', 20, 'lgc3.jpg'),
(32, 7, 'Samsung S90C OLED', 'Samsung', 151919.00, 'Vibrant QD-OLED tech', 18, 'samsungs90c.jpg'),
(33, 7, 'Sony A80L OLED', 'Sony', 159919.00, 'Acoustic Surface Audio+', 15, 'sonya80l.jpg'),
(34, 7, 'TCL R646 Mini-LED', 'TCL', 79919.00, 'Great value performance', 30, 'tclr646.jpg'),
(35, 7, 'Hisense U8K', 'Hisense', 87919.00, 'Bright and colorful', 25, 'hisenseu8k.jpg'),
(36, 8, 'PlayStation 5', 'Sony', 39919.00, 'Next-gen gaming power', 20, 'ps5.jpg'),
(37, 8, 'Xbox Series X', 'Microsoft', 39919.00, 'The fastest, most powerful Xbox', 15, 'xboxseriesx.jpg'),
(38, 8, 'Nintendo Switch OLED', 'Nintendo', 27919.00, 'Vibrant OLED screen', 40, 'switcholed.jpg'),
(39, 8, 'Steam Deck', 'Valve', 31919.00, 'Your library goes anywhere', 25, 'steamdeck.jpg'),
(40, 8, 'ASUS ROG Ally', 'Asus', 55919.00, 'Powerful handheld Windows gaming', 20, 'rogally.jpg'),
(41, 9, 'HP LaserJet Pro', 'HP', 23919.00, 'Fast black and white printing', 30, 'hplaserjet.jpg'),
(42, 9, 'Epson EcoTank', 'Epson', 27919.00, 'Cartridge-free printing', 25, 'epson.jpg'),
(43, 9, 'Canon PIXMA', 'Canon', 15919.00, 'High-quality photo printing', 35, 'canonpixma.jpg'),
(44, 9, 'Brother MFC', 'Brother', 19919.00, 'Reliable all-in-one', 20, 'brother.jpg'),
(45, 9, 'Xerox Phaser', 'Xerox', 31919.00, 'Workgroup performance', 10, 'xerox.jpg'),
(46, 10, 'MagSafe Charger', 'Apple', 3119.00, 'Fast wireless charging', 200, 'magsafe.jpg'),
(47, 11, 'Samsung Odyssey G9', 'Samsung', 103919.00, 'Ultrawide gaming monitor', 10, 'odysseyg9.jpg'),
(48, 11, 'Dell UltraSharp 27', 'Dell', 47919.00, '4K professional monitor', 15, 'dell27.jpg'),
(49, 12, 'Samsung 990 Pro 2TB', 'Samsung', 15919.00, 'Fast NVMe SSD', 50, 'ssd990pro.jpg'),
(50, 12, 'WD Black 4TB', 'WD', 10319.00, 'Reliable external storage', 40, 'wd4tb.jpg'),
(51, 10, 'Logitech MX Master 3S', 'Logitech', 7919.00, 'Ultimate productivity mouse', 80, 'mxmaster3s.jpg'),
(52, 10, 'Keychron K2', 'Keychron', 7119.00, 'Mechanical wireless keyboard', 60, 'keychronk2.jpg'),
(53, 10, '44W Flash Charger', 'TechBrand', 450.00, 'High-speed 44W flash charger with Type-C support.', 100, 'charger.jpg');

-- Insert Product Specifications
INSERT INTO Product_Specifications (product_id, spec_name, spec_value) VALUES
(1, 'Processor', 'A17 Pro (3nm)'), (1, 'Display', '6.1" Super Retina XDR OLED'), (1, 'Storage', '256GB NVMe'), (1, 'Battery', '3274 mAh'), (1, 'Camera', '48MP + 12MP + 12MP'),
(2, 'Processor', 'Snapdragon 8 Gen 3'), (2, 'Camera', '200MP Quad Telephoto'), (2, 'Display', '6.8" Dynamic AMOLED 2X'), (2, 'RAM', '12GB LPDDR5X'), (2, 'Battery', '5000 mAh'),
(3, 'Processor', 'Google Tensor G3'), (3, 'Display', '6.7" LTPO OLED'), (3, 'Camera', '50MP Main + 48MP Ultrawide'), (3, 'Features', 'Magic Eraser, Best Take'),
(4, 'Processor', 'Snapdragon 8 Gen 3'), (4, 'Charging', '100W SUPERVOOC'), (4, 'Display', '6.82" QHD+ ProXDR'),
(5, 'Optics', 'Leica Vario-Summilux'), (5, 'Sensor', '1-inch Main Sensor'), (5, 'Processor', 'Snapdragon 8 Gen 3'),
(6, 'Processor', 'Apple M3 (8-core CPU)'), (6, 'RAM', '16GB Unified Memory'), (6, 'Storage', '512GB SSD'), (6, 'Display', '13.6" Liquid Retina'),
(7, 'Processor', 'Intel Core Ultra 7'), (7, 'Display', '13.4" FHD+ InfinityEdge'), (7, 'RAM', '16GB LPDDR5x'),
(8, 'Processor', 'Intel Core i7-1355U'), (8, 'Type', '2-in-1 Convertible'), (8, 'Display', '14" 2.8K OLED Touch'),
(9, 'Processor', 'Intel Core i7 vPro'), (9, 'Build', 'Carbon Fiber Chassis'), (9, 'Security', 'Fingerprint & IR Camera'),
(10, 'GPU', 'NVIDIA RTX 4060'), (10, 'Processor', 'AMD Ryzen 9 8945HS'), (10, 'Refresh Rate', '120Hz Nebula Display'),
(11, 'Display', '12.9" Mini-LED'), (11, 'Processor', 'Apple M2'),
(12, 'Display', '14.6" Dynamic AMOLED'), (12, 'Extras', 'S-Pen Included'),
(13, 'Type', 'Surface Connect, Pro Keyboard'), (13, 'Processor', 'Intel 12th Gen i5/i7'),
(14, 'Processor', 'Apple M1'), (14, 'Display', '10.9" Liquid Retina'),
(15, 'Display', '12.6" OLED 120Hz'), (15, 'Audio', 'Quad JBL Speakers'),
(16, 'Sensor', 'Blood Oxygen, ECG'), (16, 'Chip', 'S9 SiP'),
(17, 'Bezel', 'Rotating Physical Bezel'), (17, 'Material', 'Stainless Steel'),
(18, 'GPS', 'Multi-band GNSS'), (18, 'Battery', 'Up to 28 days (Solar)'),
(19, 'Integration', 'Fitbit Health Tracking'), (19, 'OS', 'Wear OS 4'),
(20, 'Battery', '14 Days Typical Use'), (20, 'GPS', 'Dual-band Circularly Polarized'),
(21, 'Type', 'Over-ear Noise Canceling'), (21, 'Battery', '30 Hours'), (21, 'Driver', '30mm Carbon Fiber'),
(22, 'Audio', 'Immersive Spatial Audio'), (22, 'Modes', 'Quiet, Aware, Immersion'),
(23, 'Chip', 'Apple H2'), (23, 'Case', 'MagSafe with Speaker'),
(24, 'Battery', '60 Hours'), (24, 'Driver', '42mm Transducer'),
(25, 'Connectivity', 'USB-C Lossless Audio'), (25, 'Battery', '40 Hours'),
(26, 'Sensor', '33MP Full-Frame Exmor R'), (26, 'Video', '4K 60p 10-bit'),
(27, 'Sensor', '24.2MP Full-Frame'), (27, 'AF', 'Dual Pixel CMOS AF II'),
(28, 'Sensor', '40MP X-Trans CMOS 5 HR'), (28, 'Design', 'Classic Dial Interface'),
(29, 'Video', '5.3K 60fps'), (29, 'Stabilization', 'HyperSmooth 6.0'),
(30, 'Resolution', '45.7MP Stacked CMOS'), (30, 'Video', '8K 60p Internal'),
(31, 'Panel', 'OLED evo'), (31, 'Processor', 'a9 AI Processor Gen6'), (31, 'Gaming', 'G-Sync, FreeSync'),
(32, 'Panel', 'QD-OLED'), (32, 'Brightness', 'Ultra High Peak'),
(33, 'Audio', 'Acoustic Surface Audio+'), (33, 'Panel', 'XR OLED'),
(34, 'Panel', 'Mini-LED QLED'), (34, 'Dimming', 'Full Array Local Dimming'),
(35, 'Peak Brightness', '1500 nits'), (35, 'Refresh', '144Hz Native'),
(36, 'CPU', '8-core Zen 2 @ 3.5GHz'), (36, 'GPU', '10.28 TFLOPS RDNA 2'), (36, 'Storage', '825GB Custom SSD'),
(37, 'CPU', '8-core Zen 2 @ 3.8GHz'), (37, 'GPU', '12 TFLOPS RDNA 2'), (37, 'Storage', '1TB NVMe SSD'),
(38, 'Display', '7-inch OLED'), (38, 'Storage', '64GB Internal'),
(39, 'CPU', 'Zen 2 (4-core)'), (39, 'Display', '7" Touchscreen'),
(40, 'Processor', 'Ryzen Z1 Extreme'), (40, 'Display', '120Hz 1080p'),
(41, 'Type', 'Monochrome Laser'), (41, 'Speed', 'Up to 30 ppm'),
(42, 'System', 'EcoTank Ink Bottles'), (42, 'Yield', '6000 pages per set'),
(43, 'Resolution', '4800 x 1200 dpi'), (43, 'Photo', 'Borderless 4x6 in 17s'),
(44, 'Functions', 'Print, Copy, Scan, Fax'), (44, 'Speed', 'Up to 24 ppm'),
(45, 'Resolution', '1200 x 1200 dpi'), (45, 'Network', 'Ethernet, Wi-Fi'),
(46, 'Output', '15W Peak'), (46, 'Magnet', 'High-strength Alignment'),
(47, 'Size', '49-inch Curved 1000R'), (47, 'Resolution', 'Dual QHD (5120x1440)'), (47, 'Refresh', '240Hz'),
(48, 'Resolution', '4K (3840x2160)'), (48, 'Panel', 'IPS Black Technology'),
(49, 'Speed', '7450 MB/s Read'), (49, 'Type', 'PCIe Gen 4.0 x4'),
(50, 'Capacity', '4TB'), (50, 'Durability', 'Drop resistant up to 2m'),
(51, 'Sensor', '8000 DPI Darkfield'), (51, 'Scrolling', 'MagSpeed Electromagnetic'),
(52, 'Switches', 'Gateron G Pro Mechanical'), (52, 'Backlight', 'RGB / White'),
(53, 'Output', '44W Flash Charge'), (53, 'Port', 'Type-C USB');