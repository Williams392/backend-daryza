from django.db import models
from django.utils.html import format_html

class Categoria(models.Model):
    id_categoria = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    estado = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nombre

class Marca(models.Model):
    id_marca = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    estado = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nombre

class UnidadMedida(models.Model):
    id_unidad_medida = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    abreviacion = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.nombre}"


class Producto(models.Model):
    id_producto = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    precio_compra = models.DecimalField(max_digits=10, decimal_places=2)
    precio_venta = models.DecimalField(max_digits=10, decimal_places=2)
    codigo = models.CharField(max_length=100)
    estado = models.BooleanField(default=True)
    descripcion = models.TextField(blank=True, null=True)
    estock = models.IntegerField()
    estock_minimo = models.IntegerField()
    imagen = models.ImageField(upload_to='productos/', blank=True, null=True)
    
    marca = models.ForeignKey(Marca, on_delete=models.PROTECT)
    categoria = models.ForeignKey(Categoria, on_delete=models.PROTECT)
    unidad_medida = models.ForeignKey(UnidadMedida, on_delete=models.PROTECT)
    created_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.nombre}"
    
    def mostrar_imagen(self): 
        if self.imagen:
            return format_html('<img src="{}" width="100" height="100" />'.format(self.imagen.url))
        else:
            return ''
        
    mostrar_imagen.short_description = 'Imagen' # dar un titulo ala tabla

    