# Architecture

## Roles
- parent: owns children and subscription.
- admin: manages content, plans and analytics using a Firebase custom claim.
- school: reserved for the future multi-tenant school module.

## Collections
users/{uid}
users/{uid}/devices/{token}
children/{childId}
children/{childId}/progress/{lessonId}
children/{childId}/achievements/{badgeId}
stories/{storyId}
coloringPages/{pageId}
badges/{badgeId}
subscriptionPlans/{planId}
schools/{schoolId}
payments/{paymentId}
analytics/{docId}

## Security
- Payment success is never decided by Flutter.
- Subscription activation requires trusted backend verification.
- CMS writes require the admin claim.
- Parent data is restricted to the authenticated owner.
- Unknown Firestore paths are denied.
