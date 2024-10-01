from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProductoView, CategoriaViewSet, MarcaViewSet, UnidadMedidaViewSet
router = DefaultRouter()
router.register(r'categorias', CategoriaViewSet)
router.register(r'marcas', MarcaViewSet)
router.register(r'unidadesmedida', UnidadMedidaViewSet)
# router.register(r'productos', ProductoViewSet)

urlpatterns = [
    path('', include(router.urls)),

     path('productos/', ProductoView.as_view(), name='producto-list'),  # Listar y crear productos
    path('producto/<int:pk_producto>/', ProductoView.as_view(), name='producto-detail'),  # Detalles, actualizar y eliminar un producto
]