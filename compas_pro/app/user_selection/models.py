from django.db import models
from django.contrib.auth.models import AbstractBaseUser


class User(AbstractBaseUser):
    role_choice = (
        ("u", "Пользователь"),
        ("m", "Менеджер"),
        ("a", "CRM-администратор")
    )
    role = models.CharField(
        verbose_name="Место работы",
        max_length=255,
        choices=role_choice)
    avatar = models.ImageField(
        verbose_name="Фото пользователя",
        upload_to="app/user_selection/static/img"
    )
    offer = models.BooleanField(
        verbose_name="Предложение о работе",
        default=None
    )
    USERNAME_FIELD = "role", "avatar", "offer"
