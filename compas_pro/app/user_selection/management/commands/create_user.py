from django.core.management.base import BaseCommand
from user_selection.models import User


class Command(BaseCommand):
    help = u"Создание 3 пользователей"

    def handle(self, *args, **kwargs):
        user1 = User(
            role="u",
            avatar="app/user_selection/static/user_selection/img/1",
            offer=False,
            password="qwerty",
        )
        user1.save()

        user2 = User(
            role="m",
            avatar="app/user_selection/static/user_selection/img/2",
            offer=True,
            password="management",
        )
        user2.save()

        user3 = User(
            role="a",
            avatar="app/user_selection/static/user_selection/img/3",
            offer=True,
            password="admin",
        )
        user3.save()
