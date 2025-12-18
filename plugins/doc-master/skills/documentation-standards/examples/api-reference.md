# Example: API Reference Documentation

This example demonstrates comprehensive API documentation format.

## Complete Endpoint Documentation

```markdown
# Users API

## Overview

The Users API allows you to create, retrieve, update, and delete user accounts.
All endpoints require authentication via Bearer token.

Base URL: `https://api.example.com/v1`

## Authentication

Include the API key in the Authorization header:

```bash
Authorization: Bearer YOUR_API_KEY
```

## Endpoints

### List Users

Retrieve a paginated list of users.

```
GET /users
```

#### Query Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | integer | No | 1 | Page number (1-indexed) |
| limit | integer | No | 20 | Results per page (max: 100) |
| status | string | No | all | Filter by status: `active`, `inactive`, `all` |
| sort | string | No | created_at | Sort field: `created_at`, `name`, `email` |
| order | string | No | desc | Sort order: `asc`, `desc` |
| search | string | No | - | Search in name and email |

#### Response

```json
{
  "data": [
    {
      "id": "usr_123abc",
      "email": "user@example.com",
      "name": "John Doe",
      "status": "active",
      "created_at": "2024-01-15T10:30:00Z",
      "updated_at": "2024-01-20T14:45:00Z"
    }
  ],
  "meta": {
    "total": 150,
    "page": 1,
    "limit": 20,
    "pages": 8
  }
}
```

#### Example Request

```bash
curl -X GET "https://api.example.com/v1/users?status=active&limit=10" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

### Get User

Retrieve a single user by ID.

```
GET /users/{id}
```

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| id | string | User ID (format: `usr_xxxxx`) |

#### Response

```json
{
  "id": "usr_123abc",
  "email": "user@example.com",
  "name": "John Doe",
  "status": "active",
  "role": "member",
  "metadata": {
    "department": "Engineering",
    "location": "NYC"
  },
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-20T14:45:00Z"
}
```

#### Errors

| Status | Code | Description |
|--------|------|-------------|
| 404 | USER_NOT_FOUND | User with specified ID does not exist |

#### Example Request

```bash
curl -X GET "https://api.example.com/v1/users/usr_123abc" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

### Create User

Create a new user account.

```
POST /users
```

#### Request Body

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Yes | User's email address (must be unique) |
| name | string | Yes | User's full name |
| password | string | Yes | Password (min 8 chars, requires number and special char) |
| role | string | No | User role: `admin`, `member` (default: `member`) |
| metadata | object | No | Custom key-value pairs |

```json
{
  "email": "newuser@example.com",
  "name": "Jane Smith",
  "password": "SecurePass123!",
  "role": "member",
  "metadata": {
    "department": "Sales"
  }
}
```

#### Response

```json
{
  "id": "usr_456def",
  "email": "newuser@example.com",
  "name": "Jane Smith",
  "status": "active",
  "role": "member",
  "metadata": {
    "department": "Sales"
  },
  "created_at": "2024-01-25T09:00:00Z",
  "updated_at": "2024-01-25T09:00:00Z"
}
```

#### Errors

| Status | Code | Description |
|--------|------|-------------|
| 400 | INVALID_EMAIL | Email format is invalid |
| 400 | WEAK_PASSWORD | Password doesn't meet requirements |
| 409 | EMAIL_EXISTS | User with this email already exists |

#### Example Request

```bash
curl -X POST "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "name": "Jane Smith",
    "password": "SecurePass123!"
  }'
```

---

### Update User

Update an existing user.

```
PATCH /users/{id}
```

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| id | string | User ID |

#### Request Body

All fields are optional. Only include fields to update.

| Field | Type | Description |
|-------|------|-------------|
| name | string | User's full name |
| status | string | User status: `active`, `inactive` |
| role | string | User role: `admin`, `member` |
| metadata | object | Custom metadata (merges with existing) |

```json
{
  "name": "Jane Doe",
  "metadata": {
    "department": "Marketing"
  }
}
```

#### Response

Returns the updated user object.

#### Errors

| Status | Code | Description |
|--------|------|-------------|
| 404 | USER_NOT_FOUND | User does not exist |
| 400 | INVALID_STATUS | Invalid status value |

---

### Delete User

Permanently delete a user account.

```
DELETE /users/{id}
```

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| id | string | User ID |

#### Response

```json
{
  "deleted": true,
  "id": "usr_123abc"
}
```

#### Errors

| Status | Code | Description |
|--------|------|-------------|
| 404 | USER_NOT_FOUND | User does not exist |

---

## Error Responses

All errors follow this format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

### Common Error Codes

| Status | Code | Description |
|--------|------|-------------|
| 400 | BAD_REQUEST | Invalid request format |
| 401 | UNAUTHORIZED | Missing or invalid API key |
| 403 | FORBIDDEN | API key lacks permission |
| 404 | NOT_FOUND | Resource not found |
| 409 | CONFLICT | Resource already exists |
| 422 | VALIDATION_ERROR | Request validation failed |
| 429 | RATE_LIMITED | Too many requests |
| 500 | INTERNAL_ERROR | Server error |

## Rate Limits

| Plan | Requests/minute | Requests/day |
|------|-----------------|--------------|
| Free | 60 | 1,000 |
| Pro | 600 | 50,000 |
| Enterprise | Unlimited | Unlimited |

Rate limit headers:
- `X-RateLimit-Limit`: Requests allowed per minute
- `X-RateLimit-Remaining`: Requests remaining
- `X-RateLimit-Reset`: Unix timestamp when limit resets

## Pagination

List endpoints support cursor-based pagination:

```json
{
  "data": [...],
  "meta": {
    "total": 150,
    "page": 1,
    "limit": 20,
    "pages": 8,
    "has_more": true
  }
}
```

Use `page` parameter to navigate:
- `GET /users?page=1` - First page
- `GET /users?page=2` - Second page

## Versioning

API version is included in the URL path: `/v1/users`

Current version: **v1**

Deprecated versions will be announced 6 months before removal.
```
