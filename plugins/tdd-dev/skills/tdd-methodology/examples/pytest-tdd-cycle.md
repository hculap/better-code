# Pytest TDD Cycle Example

Complete walkthrough of implementing a `ShoppingCart` using strict TDD.

## Requirement

Create a shopping cart that:
- Adds items with price and quantity
- Calculates total
- Applies percentage discounts
- Handles empty cart

---

## Cycle 1: Empty Cart Total

### RED: Write Failing Test

```python
# tests/test_shopping_cart.py
import pytest
from shopping_cart import ShoppingCart


class TestShoppingCart:
    """Tests for ShoppingCart class."""

    def test_empty_cart_has_zero_total(self):
        """Empty cart should have total of 0."""
        cart = ShoppingCart()
        assert cart.total() == 0
```

**Run tests:**
```bash
pytest tests/test_shopping_cart.py -v
```

**Expected output:**
```
FAILED tests/test_shopping_cart.py::TestShoppingCart::test_empty_cart_has_zero_total
E   ModuleNotFoundError: No module named 'shopping_cart'
```

✅ Test fails for the right reason.

### GREEN: Minimal Implementation

```python
# shopping_cart.py
class ShoppingCart:
    def total(self) -> float:
        return 0
```

**Run tests:**
```bash
pytest tests/test_shopping_cart.py -v
```

```
PASSED tests/test_shopping_cart.py::TestShoppingCart::test_empty_cart_has_zero_total
```

✅ Test passes.

### REFACTOR

No refactoring needed—code is minimal.

---

## Cycle 2: Add Single Item

### RED: Write Failing Test

```python
def test_cart_with_one_item_shows_item_total(self):
    """Cart with one item should show that item's total."""
    cart = ShoppingCart()
    cart.add_item(price=10.0, quantity=2)
    assert cart.total() == 20.0
```

**Expected failure:**
```
AttributeError: 'ShoppingCart' object has no attribute 'add_item'
```

✅ Fails because method doesn't exist.

### GREEN: Minimal Implementation

```python
class ShoppingCart:
    def __init__(self):
        self._items = []

    def add_item(self, price: float, quantity: int) -> None:
        self._items.append({"price": price, "quantity": quantity})

    def total(self) -> float:
        return sum(item["price"] * item["quantity"] for item in self._items)
```

**Run tests:**
```bash
pytest tests/test_shopping_cart.py -v
```

```
PASSED test_empty_cart_has_zero_total
PASSED test_cart_with_one_item_shows_item_total
```

✅ Both tests pass.

### REFACTOR

Consider using a dataclass for items, but defer until needed.

---

## Cycle 3: Add Multiple Items

### RED: Write Failing Test

```python
def test_cart_with_multiple_items_sums_totals(self):
    """Cart should sum totals of all items."""
    cart = ShoppingCart()
    cart.add_item(price=10.0, quantity=2)  # 20
    cart.add_item(price=5.0, quantity=3)   # 15
    assert cart.total() == 35.0
```

**Run tests:**
```bash
pytest tests/test_shopping_cart.py -v
```

✅ Test passes immediately (implementation already handles this).

---

## Cycle 4: Apply Discount

### RED: Write Failing Test

```python
def test_apply_percentage_discount(self):
    """Should apply percentage discount to total."""
    cart = ShoppingCart()
    cart.add_item(price=100.0, quantity=1)
    cart.apply_discount(0.1)  # 10% off
    assert cart.total() == 90.0
```

**Expected failure:**
```
AttributeError: 'ShoppingCart' object has no attribute 'apply_discount'
```

### GREEN: Minimal Implementation

```python
class ShoppingCart:
    def __init__(self):
        self._items = []
        self._discount = 0.0

    def add_item(self, price: float, quantity: int) -> None:
        self._items.append({"price": price, "quantity": quantity})

    def apply_discount(self, percentage: float) -> None:
        self._discount = percentage

    def total(self) -> float:
        subtotal = sum(item["price"] * item["quantity"] for item in self._items)
        return subtotal * (1 - self._discount)
```

✅ Test passes.

---

## Cycle 5: Discount on Empty Cart

### RED: Write Failing Test

```python
def test_discount_on_empty_cart_is_zero(self):
    """Discount on empty cart should still be zero."""
    cart = ShoppingCart()
    cart.apply_discount(0.5)
    assert cart.total() == 0
```

✅ Test passes immediately (0 * anything = 0).

---

## Cycle 6: Invalid Discount

### RED: Write Failing Test

```python
def test_discount_over_100_percent_raises_error(self):
    """Discount over 100% should raise ValueError."""
    cart = ShoppingCart()
    with pytest.raises(ValueError, match="Discount cannot exceed 100%"):
        cart.apply_discount(1.5)

def test_negative_discount_raises_error(self):
    """Negative discount should raise ValueError."""
    cart = ShoppingCart()
    with pytest.raises(ValueError, match="Discount cannot be negative"):
        cart.apply_discount(-0.1)
```

### GREEN: Minimal Implementation

```python
def apply_discount(self, percentage: float) -> None:
    if percentage < 0:
        raise ValueError("Discount cannot be negative")
    if percentage > 1:
        raise ValueError("Discount cannot exceed 100%")
    self._discount = percentage
```

✅ All tests pass.

---

## Cycle 7: Refactor - Extract Item Class

Now that we have good test coverage, refactor to improve code quality.

### REFACTOR: Extract Dataclass

```python
# shopping_cart.py
from dataclasses import dataclass
from typing import List


@dataclass
class CartItem:
    """Represents an item in the shopping cart."""
    price: float
    quantity: int

    @property
    def subtotal(self) -> float:
        return self.price * self.quantity


class ShoppingCart:
    """Shopping cart with discount support."""

    def __init__(self):
        self._items: List[CartItem] = []
        self._discount: float = 0.0

    def add_item(self, price: float, quantity: int) -> None:
        """Add an item to the cart."""
        self._items.append(CartItem(price=price, quantity=quantity))

    def apply_discount(self, percentage: float) -> None:
        """Apply a percentage discount (0.0 to 1.0)."""
        if percentage < 0:
            raise ValueError("Discount cannot be negative")
        if percentage > 1:
            raise ValueError("Discount cannot exceed 100%")
        self._discount = percentage

    def total(self) -> float:
        """Calculate the total with discount applied."""
        subtotal = sum(item.subtotal for item in self._items)
        return subtotal * (1 - self._discount)
```

**Run all tests after refactor:**
```bash
pytest tests/test_shopping_cart.py -v
```

```
PASSED test_empty_cart_has_zero_total
PASSED test_cart_with_one_item_shows_item_total
PASSED test_cart_with_multiple_items_sums_totals
PASSED test_apply_percentage_discount
PASSED test_discount_on_empty_cart_is_zero
PASSED test_discount_over_100_percent_raises_error
PASSED test_negative_discount_raises_error
```

✅ All tests still pass after refactoring.

---

## Final Test File

```python
# tests/test_shopping_cart.py
import pytest
from shopping_cart import ShoppingCart


class TestShoppingCart:
    """Tests for ShoppingCart class."""

    def test_empty_cart_has_zero_total(self):
        """Empty cart should have total of 0."""
        cart = ShoppingCart()
        assert cart.total() == 0

    def test_cart_with_one_item_shows_item_total(self):
        """Cart with one item should show that item's total."""
        cart = ShoppingCart()
        cart.add_item(price=10.0, quantity=2)
        assert cart.total() == 20.0

    def test_cart_with_multiple_items_sums_totals(self):
        """Cart should sum totals of all items."""
        cart = ShoppingCart()
        cart.add_item(price=10.0, quantity=2)
        cart.add_item(price=5.0, quantity=3)
        assert cart.total() == 35.0

    def test_apply_percentage_discount(self):
        """Should apply percentage discount to total."""
        cart = ShoppingCart()
        cart.add_item(price=100.0, quantity=1)
        cart.apply_discount(0.1)
        assert cart.total() == 90.0

    def test_discount_on_empty_cart_is_zero(self):
        """Discount on empty cart should still be zero."""
        cart = ShoppingCart()
        cart.apply_discount(0.5)
        assert cart.total() == 0

    def test_discount_over_100_percent_raises_error(self):
        """Discount over 100% should raise ValueError."""
        cart = ShoppingCart()
        with pytest.raises(ValueError, match="Discount cannot exceed 100%"):
            cart.apply_discount(1.5)

    def test_negative_discount_raises_error(self):
        """Negative discount should raise ValueError."""
        cart = ShoppingCart()
        with pytest.raises(ValueError, match="Discount cannot be negative"):
            cart.apply_discount(-0.1)
```

---

## Summary

| Cycle | Phase | Action |
|-------|-------|--------|
| 1 | RED/GREEN | Empty cart returns 0 |
| 2 | RED/GREEN | Single item total |
| 3 | GREEN | Multiple items (already works) |
| 4 | RED/GREEN | Apply discount |
| 5 | GREEN | Discount on empty (already works) |
| 6 | RED/GREEN | Invalid discount validation |
| 7 | REFACTOR | Extract CartItem dataclass |

**Total: 7 TDD cycles, 7 tests, clean refactored code.**
