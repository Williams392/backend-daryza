# Generated by Django 5.1.1 on 2024-10-18 08:02

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('gestion_almacen', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Sucursal',
            fields=[
                ('id_sucursal', models.AutoField(primary_key=True, serialize=False)),
                ('nombre', models.CharField(max_length=50)),
                ('descripcion', models.CharField(max_length=50, null=True)),
                ('telf_suc', models.CharField(max_length=20)),
                ('correo_suc', models.CharField(max_length=25)),
                ('direccion', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='TipoMovimiento',
            fields=[
                ('id_tipoMovimiento', models.AutoField(primary_key=True, serialize=False)),
                ('descripcion', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'tb_tipoMovimiento',
            },
        ),
        migrations.CreateModel(
            name='Movimiento',
            fields=[
                ('id_movimiento', models.AutoField(primary_key=True, serialize=False)),
                ('serie', models.CharField(max_length=7, unique=True)),
                ('correlativo', models.CharField(max_length=5, unique=True)),
                ('fecha', models.DateField()),
                ('fecha_entrega', models.DateField()),
                ('referencia', models.CharField(max_length=50, null=True)),
                ('cant_total', models.IntegerField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('sucursal', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='movimientos.sucursal')),
                ('tipo_movimiento', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='movimientos.tipomovimiento')),
            ],
            options={
                'db_table': 'tb_movimiento',
            },
        ),
        migrations.CreateModel(
            name='DetalleMovimiento',
            fields=[
                ('id_detalleMovimiento', models.AutoField(primary_key=True, serialize=False)),
                ('cantidad', models.IntegerField()),
                ('producto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='gestion_almacen.producto')),
                ('movimiento', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='movimientos.movimiento')),
            ],
            options={
                'db_table': 'tb_detalleMovimiento',
            },
        ),
    ]
