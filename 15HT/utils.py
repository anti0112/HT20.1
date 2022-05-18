import sqlite3


def execute(query, args=None):
    connection = sqlite3.connect('animal.db')
    cursor = connection.cursor()
    cursor.execute(query, args)
    result = cursor.fetchall()
    connection.close()
    return result


def get_cat(idx):
    query = """
            SELECT DISTINCT new_animal.name, Statuses.status, new_animal.date_of_birth, colors1.color, colors2.color
            FROM outcome
            LEFT JOIN Statuses ON outcome.status_id = Statuses.status_id
            LEFT JOIN new_animal ON outcome.animal_id = new_animal.animal_id
            LEFT JOIN colors colors1 ON new_animal.main_color_id = colors1.color_id
            LEFT JOIN colors colors2 ON new_animal.second_color_id = colors2.color_id
            WHERE id = :id;           
"""
    data = execute(query, {'id': idx})[0]
    cat = {
        'name': data[0],
        'status': data[1],
        'date_of_birth': data[2],
        'main_color': data[3],
        'second_color': data[4]
    }
    return cat