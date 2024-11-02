-- -------------------
-- codigo SQL SERVER:
-- -------------------

create database BD_DARYZA_T3_v8;
use BD_DARYZA_T3_v8;


-- 1. Crear tabla tb_rol:
CREATE TABLE tb_rol (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    name_role NVARCHAR(50) UNIQUE NOT NULL
);
GO
INSERT INTO tb_rol (name_role) VALUES
('Asignar'),
('Administrador'),
('Ventas'),
('Almacen');

-------------------------------------------------------------------------------------------------------------------------------------
-- 2. tabla actual de django:
CREATE TABLE tb_usuario (
    id_user INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    created DATETIME2(6) NOT NULL DEFAULT GETDATE(),
    modified DATETIME2(6) NOT NULL DEFAULT GETDATE(),
    is_superuser TINYINT NOT NULL,
    is_staff TINYINT NOT NULL,
    is_active TINYINT NOT NULL,
    date_joined DATETIME2(6) NOT NULL,
    last_login DATETIME2(6),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    name_role_id INT,
    CONSTRAINT FK_Rol FOREIGN KEY (name_role_id) REFERENCES tb_rol(id_rol)
);
GO
INSERT INTO tb_usuario (username, email, phone_number, password, name_role_id, created, modified, is_superuser, is_staff, is_active, date_joined) VALUES
('kevin1', 'kevin1@gmail.com', '+51999999991', 'admin123456', 2, SYSDATETIME(), SYSDATETIME(), 1, 1, 1, SYSDATETIME()),
('Sebas2', 'sebas2@gmail.com', '+51999999992', 'admin123456', 3, SYSDATETIME(), SYSDATETIME(), 0, 0, 1, SYSDATETIME());

-------------------------------------------------------------------------------------------------------------------------------------
-- 3. Crear tabla tb_categoria (usada como FK en tb_producto)
CREATE TABLE tb_categoria (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria NVARCHAR(100) NOT NULL,
    estado_categoria BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    update_at DATETIME DEFAULT GETDATE()
);
INSERT INTO tb_categoria (nombre_categoria, estado_categoria, created_at, update_at) VALUES
('Detergente Líquido', 1, GETDATE(), GETDATE()),
('Desinfectante', 1, GETDATE(), GETDATE()),
('Jabón Líquido', 1, GETDATE(), GETDATE()),
('Lejía', 1, GETDATE(), GETDATE()),
('Suavizante', 1, GETDATE(), GETDATE()),
('Limpiador Multiusos', 1, GETDATE(), GETDATE()),
('Desengrasante', 1, GETDATE(), GETDATE()),
('Aromatizador', 1, GETDATE(), GETDATE()),
('Cera Líquida', 1, GETDATE(), GETDATE()),
('Lavavajillas', 1, GETDATE(), GETDATE());

-------------------------------------------------------------------------------------------------------------------------------------
-- 4. Crear tabla tb_marca (usada como FK en tb_producto)
CREATE TABLE tb_marca (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre_marca NVARCHAR(100) NOT NULL,
    estado_marca BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    update_at DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO tb_marca (nombre_marca, estado_marca, created_at, update_at) VALUES
('Daryza', 1, GETDATE(), GETDATE()),
('Clorox', 1, GETDATE(), GETDATE()),
('Lysol', 1, GETDATE(), GETDATE()),
('Mr. Clean', 1, GETDATE(), GETDATE()),
('Fabuloso', 1, GETDATE(), GETDATE()),
('Ajax', 1, GETDATE(), GETDATE()),
('Pine-Sol', 1, GETDATE(), GETDATE()),
('Windex', 1, GETDATE(), GETDATE()),
('Scrubbing Bubbles', 1, GETDATE(), GETDATE()),
('Seventh Generation', 1, GETDATE(), GETDATE());

-------------------------------------------------------------------------------------------------------------------------------------
-- 5. Crear tabla tb_unidadMedida (usada como FK en tb_producto)
CREATE TABLE tb_unidadMedida (
    id_unidadMedida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_unidad NVARCHAR(100) NOT NULL,
    abreviacion NVARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    update_at DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO tb_unidadMedida (nombre_unidad, abreviacion, created_at, update_at) VALUES
('Litro', 'L', GETDATE(), GETDATE()),
('Mililitro', 'ml', GETDATE(), GETDATE()),
('Galón', 'gal', GETDATE(), GETDATE()),
('Onza', 'oz', GETDATE(), GETDATE()),
('Kilogramo', 'kg', GETDATE(), GETDATE()),
('Gramo', 'g', GETDATE(), GETDATE()),
('Unidad', 'u', GETDATE(), GETDATE()),
('Paquete', 'paq', GETDATE(), GETDATE()),
('Caja', 'caja', GETDATE(), GETDATE()),
('Botella', 'bot', GETDATE(), GETDATE());

-------------------------------------------------------------------------------------------------------------------------------------
-- 6. Crear tabla tb_producto (usa FK de tb_marca, tb_categoria, tb_unidadMedida)
CREATE TABLE tb_producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_prod NVARCHAR(100) NOT NULL,
    descripcion_pro NVARCHAR(MAX) NULL,
    precio_compra DECIMAL(10, 2) NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    codigo NVARCHAR(100) NOT NULL,
    estado BIT DEFAULT 1,
    estock INT NOT NULL,
    estock_minimo INT NOT NULL,
    imagen NVARCHAR(MAX) NULL,
    marca INT NOT NULL,
    categoria INT NOT NULL,
    unidad_medida INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    update_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Marca FOREIGN KEY (marca) REFERENCES tb_marca(id_marca),
    CONSTRAINT FK_Categoria FOREIGN KEY (categoria) REFERENCES tb_categoria(id_categoria),
    CONSTRAINT FK_UnidadMedida FOREIGN KEY (unidad_medida) REFERENCES tb_unidadMedida(id_unidadMedida)
);
GO
INSERT INTO tb_producto (nombre_prod, descripcion_pro, precio_compra, precio_venta, codigo, estado, estock, estock_minimo, marca, categoria, unidad_medida)
VALUES ('Producto A', 'Descripción del Producto A', 10.00, 15.00, 'P001', 1, 100, 10, 1, 1, 1),
	   ('Producto B', 'Descripción del Producto B', 20.00, 25.00, 'P002', 1, 100, 10, 1, 1, 1);

------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Crear tabla tb_paciente
CREATE TABLE tb_cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_clie NVARCHAR(255) NULL,
    apellido_clie NVARCHAR(255) NULL,

    dni_cliente NVARCHAR(8) UNIQUE NOT NULL,
	ruc_cliente NVARCHAR(11) UNIQUE NOT NULL,
	direccion_clie NVARCHAR(255) NULL,
	razon_socialCliente NVARCHAR(255) NULL,
	
	tipo_empresa NVARCHAR(255) NULL,
    email_cliente NVARCHAR(50) NULL,
    telefono_cliente NVARCHAR(20) NULL
);
GO

INSERT INTO tb_cliente (nombre_clie, apellido_clie, direccion_clie, dni_cliente, ruc_cliente, tipo_empresa, email_cliente, telefono_cliente)
VALUES 
('Juan', 'Pérez', 'Av. Principal 123', '12345678', '20123456789', 'Natural', 'juan.perez@example.com', '987654321'),
('María', 'Gómez', 'Calle Secundaria 456', '23456789', '20123456790', 'Natural', 'maria.gomez@example.com', '987654322'),
('Luis', 'Martínez', 'Jr. Los Olivos 789', '34567890', '20123456791', 'Natural', 'luis.martinez@example.com', '987654323'),
('Ana', 'López', 'Paseo de la República 101', '45678901', '20123456792', 'Natural', 'ana.lopez@example.com', '987654324'),
('Carlos', 'Sánchez', 'Av. Los Jardines 202', '56789012', '20123456793', 'Natural', 'carlos.sanchez@example.com', '987654325'),
('Fernanda', 'Díaz', 'Calle de la Paz 303', '67890123', '20123456794', 'Natural', 'fernanda.diaz@example.com', '987654326'),
('Diego', 'Reyes', 'Av. Santa Cruz 404', '78901234', '20123456795', 'Natural', 'diego.reyes@example.com', '987654327'),
('Laura', 'Hernández', 'Calle del Sol 505', '89012345', '20123456796', 'Natural', 'laura.hernandez@example.com', '987654328'),
('Andrés', 'Ramírez', 'Av. Los Angeles 606', '90123456', '20123456797', 'Natural', 'andres.ramirez@example.com', '987654329'),
('Patricia', 'Torres', 'Paseo de los Héroes 707', '01234567', '20123456798', 'Natural', 'patricia.torres@example.com', '987654330'),
('Francisco', 'Cruz', 'Av. La Libertad 808', '12345679', '20123456799', 'Natural', 'francisco.cruz@example.com', '987654331'),
('Sofía', 'Vargas', 'Calle de la Esperanza 909', '23456780', '20123456800', 'Natural', 'sofia.vargas@example.com', '987654332'),
('Javier', 'Castro', 'Calle del Río 1001', '34567891', '20123456801', 'Natural', 'javier.castro@example.com', '987654333'),
('Nadia', 'Salazar', 'Calle del Bosque 1102', '45678902', '20123456802', 'Natural', 'nadia.salazar@example.com', '987654334'),
('Ricardo', 'Alvarez', 'Av. Las Flores 1203', '56789013', '20123456803', 'Natural', 'ricardo.alvarez@example.com', '987654335');

-------------------------------------------------------------------------------------------------------------------------------------
-- 8. Tabla: tb_legend
CREATE TABLE tb_legend (
    id_legend INT IDENTITY(1,1) PRIMARY KEY,
    legend_code NVARCHAR(4) NOT NULL,
    legend_value NVARCHAR(MAX) NOT NULL
);
GO
INSERT INTO tb_legend (legend_code, legend_value)
VALUES 
('1000', 'SON VEINTITRÉS CON 60/100 SOLES'),
('1000', 'SON VEINTITRÉS CON 60/100 SOLES');

-------------------------------------------------------------------------------------------------------------------------------------
-- 9. Tabla: tb_forma_pago
CREATE TABLE tb_forma_pago (
    id_formaPago INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(30) NOT NULL,
    monto DECIMAL(10, 2) DEFAULT 0.00,
    cuota INT DEFAULT 0,
    fecha_emision DATE DEFAULT GETDATE(),
    fecha_vencimiento DATE DEFAULT GETDATE()
);
GO

INSERT INTO tb_forma_pago (tipo, monto, cuota, fecha_emision, fecha_vencimiento)
VALUES 
('Efectivo', 150.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Tarjeta', 200.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Transferencia', 250.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Crédito', 300.00, 3, GETDATE(), DATEADD(DAY, 90, GETDATE())),
('Debito', 120.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Cheque', 400.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Pago a plazos', 600.00, 6, GETDATE(), DATEADD(DAY, 180, GETDATE())),
('Contado', 350.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Prepago', 90.00, 1, GETDATE(), DATEADD(DAY, 30, GETDATE())),
('Crédito a 6 meses', 500.00, 6, GETDATE(), DATEADD(MONTH, 6, GETDATE()));

-------------------------------------------------------------------------------------------------------------------------------------
-- 10. Crear tabla tb_sucursal (usada como FK en tb_comprobante y tb_movimiento)
CREATE TABLE tb_sucursal (
    id_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    descripcion NVARCHAR(50) NULL,
    telf_suc NVARCHAR(20) NOT NULL,
    correo_suc NVARCHAR(25) NOT NULL,
    direccion NVARCHAR(50) NOT NULL
);
GO
INSERT INTO tb_sucursal (nombre, descripcion, telf_suc, correo_suc, direccion) VALUES
('Daryza S.A.C lurin', 'Panamericana Sur, luirn', '99293948', 'webmaster@daryza.com', 'km30, antigua panamericana Sur, luirn');

-------------------------------------------------------------------------------------------------------------------------------------
-- 11. Crear tabla tb_comprobante (usa FK de tb_empresa, tb_paciente, tb_impuesto, tb_estado_comprobante, tb_sucursal, tb_tipo_comprobante, tb_usuario, tb_movimiento)
-- Tabla: tb_comprobante
CREATE TABLE tb_comprobante (
    id_comprobante INT IDENTITY(1,1) PRIMARY KEY,
    tipo_operacion NVARCHAR(4) NOT NULL,
    tipo_doc NVARCHAR(4) NOT NULL,
    numero_serie NVARCHAR(4) NOT NULL,
    correlativo NVARCHAR(25) NOT NULL,
    tipo_moneda NVARCHAR(3) NOT NULL,
    fecha_emision DATE DEFAULT GETDATE(),
    hora_emision TIME DEFAULT GETDATE(),
    empresa_ruc NVARCHAR(11) NOT NULL,
    razon_social NVARCHAR(50) NOT NULL,
    nombre_comercial NVARCHAR(200) NULL,
    urbanizacion NVARCHAR(200) NULL,
    distrito NVARCHAR(100) NULL,
    departamento NVARCHAR(100) NULL,
    email_empresa NVARCHAR(50) NULL,
    telefono_emp NVARCHAR(50) NULL,
    cliente_tipo_doc NVARCHAR(11) NOT NULL,
    monto_Oper_Gravadas DECIMAL(10, 2) DEFAULT 0.00 NULL,
    monto_Igv DECIMAL(10, 2) DEFAULT 0.00 NULL,
    valor_venta DECIMAL(10, 2) DEFAULT 0.00 NULL,
    sub_Total DECIMAL(10, 2) DEFAULT 0.00 NULL,
    monto_Imp_Venta DECIMAL(10, 2) DEFAULT 0.00 NULL,
    estado_Documento NVARCHAR(1) DEFAULT '0',
    manual BIT DEFAULT 0,
    pdf_url NVARCHAR(255) NULL,
    forma_pago INT NULL,
    legend_comprobante INT NULL,
    cliente INT NULL,
    usuario INT NULL,
    CONSTRAINT FK_tb_comprobante_forma_pago FOREIGN KEY (forma_pago) REFERENCES tb_forma_pago(id_formaPago) ON DELETE CASCADE,
    CONSTRAINT FK_tb_comprobante_legend FOREIGN KEY (legend_comprobante) REFERENCES tb_legend(id_legend) ON DELETE CASCADE,
    CONSTRAINT FK_tb_comprobante_cliente FOREIGN KEY (cliente) REFERENCES tb_cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT FK_tb_comprobante_usuario FOREIGN KEY (usuario) REFERENCES tb_usuario(id_user) ON DELETE CASCADE
);
GO
INSERT INTO tb_comprobante (tipo_operacion, tipo_doc, numero_serie, correlativo, tipo_moneda, fecha_emision, hora_emision, empresa_ruc, razon_social, nombre_comercial, urbanizacion, distrito, departamento, email_empresa, telefono_emp, cliente_tipo_doc, monto_Oper_Gravadas, monto_Igv, valor_venta, sub_Total, monto_Imp_Venta, estado_Documento, manual, pdf_url, forma_pago, legend_comprobante, cliente, usuario) VALUES
('001', 'B001', '0010', '000001', 'PEN', GETDATE(), GETDATE(), '20512345678', 'Daryza S.A.C.', 'Daryza', 'Urbanización 1', 'Lima', 'Lima', 'info@daryza.com', '01-2345678', '12345678', 1000.00, 180.00, 1180.00, 1180.00, 1180.00, '1', 0, 'http://url.com/comprobante1.pdf', 1, 1, 1, 1),
('002', 'B002', '0020', '000002', 'PEN', GETDATE(), GETDATE(), '20512345678', 'Daryza S.A.C.', 'Daryza', 'Urbanización 2', 'Miraflores', 'Lima', 'ventas@daryza.com', '01-8765432', '12345678', 500.00, 90.00, 590.00, 590.00, 590.00, '1', 0, 'http://url.com/comprobante2.pdf', 2, 2, 2, 1);
SELECT * FROM tb_comprobante;

-------------------------------------------------------------------------------------------------------------------------------------
-- 12. Tabla: tb_detalle_comprobante
CREATE TABLE tb_detalle_comprobante (
    id_detalleComprobante INT IDENTITY(1,1) PRIMARY KEY,
    unidad NVARCHAR(6) NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    id_producto NVARCHAR(10) NOT NULL,
    descripcion NVARCHAR(255) NOT NULL,
    monto_valorUnitario FLOAT DEFAULT 0,
    igv_detalle FLOAT DEFAULT 0,
    fecha_emision DATE DEFAULT GETDATE(),
    hora_emision TIME DEFAULT GETDATE(),
    monto_Precio_Unitario DECIMAL(10, 2) DEFAULT 0,
    monto_Valor_Venta DECIMAL(10, 2) DEFAULT 0,
    comprobante INT NULL,
    producto INT NULL,
    CONSTRAINT FK_tb_detalle_comprobante_comprobante FOREIGN KEY (comprobante) REFERENCES tb_comprobante(id_comprobante) ON DELETE CASCADE,
    CONSTRAINT FK_tb_detalle_comprobante_producto FOREIGN KEY (producto) REFERENCES tb_producto(id_producto) ON DELETE CASCADE
);
GO
INSERT INTO tb_detalle_comprobante (unidad, cantidad, id_producto, descripcion, monto_valorUnitario, igv_detalle, monto_Precio_Unitario, monto_Valor_Venta, comprobante, producto)
VALUES 
('KG', 10, 'P001', 'Detergente Líquido', 15.00, 2.70, 150.00, 162.70, 1, 1),
('LT', 5, 'P002', 'Limpiador Multiusos', 20.00, 3.60, 100.00, 106.60, 2, 2);
select * from tb_detalle_comprobante;
---------------------------------------------------------------------------------------------------------------------------------
-- 13. Crear tabla tb_tipoMovimiento
CREATE TABLE tb_tipoMovimiento (
    id_tipoMovimiento INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(50) NOT NULL
);
GO
INSERT INTO tb_tipoMovimiento (descripcion) VALUES
('Entrada'),
('Salida');
select * from tb_tipoMovimiento;
---------------------------------------------------------------------------------------------------------------------------------

-- 14. Crear tabla tb_movimiento (usa FK de tb_sucursal, tb_usuario, tb_tipoMovimiento)
CREATE TABLE tb_movimiento (
    id_movimiento INT IDENTITY(1,1) PRIMARY KEY,
    referencia NVARCHAR(50) NULL,
    cant_total INT NOT NULL CHECK (cant_total >= 0),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    sucursal INT NOT NULL,
    usuario INT NOT NULL,
    tipo_movimiento INT NOT NULL,
    CONSTRAINT FK_tb_movimiento_sucursal FOREIGN KEY (sucursal) REFERENCES tb_sucursal(id_sucursal) ON DELETE CASCADE,
    CONSTRAINT FK_tb_movimiento_usuario FOREIGN KEY (usuario) REFERENCES tb_usuario(id_user) ON DELETE CASCADE,
    CONSTRAINT FK_tb_movimiento_tipoMovimiento FOREIGN KEY (tipo_movimiento) REFERENCES tb_tipoMovimiento(id_tipoMovimiento) ON DELETE CASCADE
);
GO
INSERT INTO tb_movimiento (referencia, cant_total, sucursal, created_at, updated_at, usuario, tipo_movimiento)
VALUES 
('Ingreso de productos', 200, 1, GETDATE(), GETDATE(), 1, 1),
('Venta de productos', 1, 1, GETDATE(), GETDATE(), 2, 1);

-------------------------------------------------------------------------------------------------------------------------------------
-- 15. Crear tabla tb_detalleMovimiento (usa FK de tb_detalle_comprobante, tb_producto y tb_movimiento)
CREATE TABLE tb_detalleMovimiento (
    id_detalleMovimiento INT IDENTITY(1,1) PRIMARY KEY,
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    detalleComprobante INT NOT NULL,
    producto INT NOT NULL,
    movimiento INT NOT NULL,
    CONSTRAINT FK_tb_detalleMovimiento_detalleComprobante FOREIGN KEY (detalleComprobante) REFERENCES tb_detalle_comprobante(id_detalleComprobante) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_tb_detalleMovimiento_producto FOREIGN KEY (producto) REFERENCES tb_producto(id_producto) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_tb_detalleMovimiento_movimiento FOREIGN KEY (movimiento) REFERENCES tb_movimiento(id_movimiento) ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO tb_detalleMovimiento (cantidad, detalleComprobante, producto, movimiento)
VALUES 
(200, 1, 1, 1), 
(1, 1, 2, 2);
select * from tb_detalle_comprobante;
-------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------- TRIGGER ------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------------

create table AUDITORIA ( -- NUEVA TABLA:
	CODIGO_AU INT IDENTITY(1,1) PRIMARY KEY,
	USUARIO_AU VARCHAR(50) NOT NULL,
	TABLA VARCHAR(50) NOT NULL,
	ACCION VARCHAR(20) NOT NULL,
	REGISTRO VARCHAR(20) NOT NULL,
	NOMBRE VARCHAR(100) NOT NULL,
	DESCRIPCION VARCHAR(50),
	FECHA_HORA DATETIME NOT NULL
)
GO

-- TRIGGER INSERTAR PARA tb_producto
CREATE TRIGGER TR_AuditoriaP_Insertar
ON tb_producto
FOR INSERT
AS
BEGIN
    INSERT INTO AUDITORIA 
    SELECT 'DESCONOCIDO', 'PRODUCTO', 'INSERTÓ', 
           CONVERT(NVARCHAR(12), id_producto), 
           nombre_prod, 
           'NINGUNA', 
           GETDATE()
    FROM inserted;
END;
GO

INSERT INTO tb_producto (nombre_prod, descripcion_pro, precio_compra, precio_venta, codigo, estado, estock, estock_minimo, marca, categoria, unidad_medida)
VALUES ('Producto A', 'Descripción del Producto A', 10.00, 15.00, 'P001', 1, 100, 10, 1, 1, 1);
GO

SELECT * FROM tb_producto;
SELECT * FROM AUDITORIA;
GO

-------------------------------------

-- TRIGGER ELIMINAR PARA tb_producto
CREATE TRIGGER TR_AuditoriaP_Eliminar
ON tb_producto
FOR DELETE
AS
BEGIN
    INSERT INTO AUDITORIA 
    SELECT 'DESCONOCIDO', 'PRODUCTO', 'ELIMINÓ', 
           CONVERT(NVARCHAR(12), id_producto), 
           nombre_prod, 
           'NINGUNA', 
           GETDATE()
    FROM deleted;
END;
GO

DELETE FROM tb_producto
WHERE id_producto = 2;  
GO

SELECT * FROM tb_producto;
SELECT * FROM AUDITORIA;
GO

-------------------------------------

-- TRIGGER ACTUALIZAR PARA tb_producto
CREATE TRIGGER TR_AuditoriaP_Actualizar
ON tb_producto
FOR UPDATE
AS
BEGIN
    INSERT INTO AUDITORIA 
    SELECT 'DESCONOCIDO', 'PRODUCTO', 'ACTUALIZÓ', 
           CONVERT(NVARCHAR(12), id_producto), 
           nombre_prod, 
           (SELECT nombre_prod FROM deleted), 
           GETDATE()
    FROM inserted;
END;
GO

UPDATE tb_producto
SET nombre_prod = 'Producto A Actualizado'
WHERE id_producto = 3; 
GO

-- Verificar auditoría
SELECT * FROM tb_producto;
SELECT * FROM AUDITORIA;