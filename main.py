from api import request


response = request('GET', 'https://jsonplaceholder.typicode.com/todos/1')
assert response.status_code == 200
print(response.body)