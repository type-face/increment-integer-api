# Increment Integer Api
Authenticated API that provides users with an integer value that can be set to a non-negative number and incremented as needed.

Note that integers returned are not necesarily unique for the user. i.e. the integer may be set to a previously returned value, or a value less than one previously returned.

Authentication is provided through tokens.

Live demo available at https://quiet-savannah-15358.herokuapp.com

## Sample API requests
`<access_token>`, `<client>`, `<expiry>`, `<uid>` will be returned by the server as headers after a successful request to the `/auth` or `auth/sign_in` endpoints. `<user_id>` will be returned in the response body.

### Register
```bash
curl -X POST \
  https://<host>/auth \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Host: <host>' \
  -d '{ "email": "<email_address>", "password": "<password>" }'
```

### Sign-in 
```bash
curl -X POST \
   https://<host>/auth/sign_in \
   -H 'Content-Type: application/vnd.api+json' \
   -H 'Host: <host>' \
   -d '{ "email": "<email_address>", "password": "<password>" }'
```

### Get current integer
```bash
curl -X GET \
  https://<host>/v1/current \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Host: <host>' \
  -H 'access-token: <access_token>' \
  -H 'client: <client>' \
  -H 'expiry: <expiry>' \
  -H 'token-type: Bearer' \
  -H 'uid: <uid>'
```

### Increment integer
```bash
curl -X PATCH \
  https://<host>/v1/increment \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Host: <host>' \
  -H 'access-token: <access_token>' \
  -H 'client: <client>' \
  -H 'expiry: <expiry>' \
  -H 'token-type: Bearer' \
  -H 'uid: <uid>'
```

### Set current integer
```bash
curl -X PATCH \
  https://<host>/v1/current \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Host: <host>' \
  -H 'access-token: <access_token>' \
  -H 'client: <client>' \
  -H 'expiry: <expiry>' \
  -H 'token-type: Bearer' \
  -H 'uid: <uid>' \
  -d '{ "data": { "type": "User", "id": <user_id>, "attributes": { "incrementer": "150" } } }'
```