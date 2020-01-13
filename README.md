Monster Shop Extensions
Instructions
Fork this repository or use your existing project.
Clone your fork if you have forked.
When you are finished, push your code to your fork. (if you have forked)
Coupon Codes
General Goals
Merchant users can generate coupon codes within the system.

Completion Criteria
Merchant users have a link on their dashboard to manage their coupons.

Merchant userss have full CRUD functionality over their coupons with exceptions mentioned below:

merchant users cannot delete a coupon that has been used in an order
Note: Coupons cannot be for greater than 100% off.
A coupon will have a coupon name, a coupon code, and a percent-off value. The name must be unique in the whole database.

Users need a way to add a coupon code when checking out. Only one coupon may be used per order.

A coupon code from a merchant only applies to items sold by that merchant.

Implementation Guidelines
If a user adds a coupon code, they can continue shopping. The coupon code is still remembered when returning to the cart page. (This information should not be stored in the database until after checkout. )
The cart show page should calculate subtotals and the grand total as usual, but also show a "discounted total".
Users can enter different coupon codes until they finish checking out, then the last code entered before clicking checkout is final.
Order show pages should display which coupon was used, as well as the discounted price.
Extensions
Coupons can be used by multiple users, but may only be used one time per user.
Merchant users can enable/disable coupon codes
Merchant users can have a maximum of 5 coupons in the system
