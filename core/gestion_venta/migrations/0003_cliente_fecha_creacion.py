# Generated by Django 5.1.1 on 2024-11-02 08:51

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gestion_venta', '0002_alter_comprobante_tipo_doc_alter_formapago_tipo'),
    ]

    operations = [
        migrations.AddField(
            model_name='cliente',
            name='fecha_creacion',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
    ]
