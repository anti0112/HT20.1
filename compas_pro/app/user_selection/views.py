from django.http import HttpResponse
from django.shortcuts import render
from user_selection.models import User


def get_user(request, id):
    users = User.objects.all()
    print(users)
    for user in users:
        if user.id == id:
            return render(request, "user_selection/index.html", user=user)
    return HttpResponse("Нет юзера с таким id")
