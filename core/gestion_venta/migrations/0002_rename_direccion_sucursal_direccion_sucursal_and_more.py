# Generated by Django 5.1.1 on 2024-11-06 02:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('gestion_venta', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='sucursal',
            old_name='direccion',
            new_name='direccion_sucursal',
        ),
        migrations.RenameField(
            model_name='sucursal',
            old_name='nombre',
            new_name='nombre_sucursal',
        ),
    ]
