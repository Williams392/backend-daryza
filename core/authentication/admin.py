from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import CustomUser, Rol

class CustomUserAdmin(UserAdmin):
    list_display = ('id', 'username', 'last_name', 'email', 'phone_number', 'date_joined', 'name_role')
    list_filter = ('date_joined',)
    search_fields = ('id', 'username', 'last_name', 'email', 'phone_number')
    date_hierarchy = 'date_joined'
    ordering = ('-id',)

    fieldsets = (
        (None, {
            "fields": ("username", "password")
        }),
        ("Información del usuario", {
            'fields': ('first_name', 'last_name', 'email', 'phone_number', 'name_role')
        }),
        ("Permisos", {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')
        }),
        ("Fechas importantes", {
            'fields': ('last_login', 'date_joined')
        }),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2', 'name_role'),
        }),
    )

class RoleAdmin(admin.ModelAdmin):
    list_display = ('id', 'name_role')

class ProfileAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'name_role')

admin.site.register(CustomUser, CustomUserAdmin)
# admin.site.register(Perfil, ProfileAdmin)
admin.site.register(Rol, RoleAdmin)
