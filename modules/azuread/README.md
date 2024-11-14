## README

### Description

These modules are intended to create and manage Azure AD resources needed for my business and following its needs and standards.  
This includes the following guidelines:  
* Users
  * User UPNs always use the primary domain as their UPN suffix
  * Admin UPNs always use the initial domain as their UPN suffix
* Groups
  * tbd
* Roles
  * tbd
  
If you make use of the modules please either use the same guidelines or download and customize the modules to your needs.  

### Example

For an example how to use the modules please navigate to:  
https://github.com/uplink-systems/Terraform-Modules/tree/main/examples/azuread  

## Modules

### Module 'user'

[Module README](user/README.md)  

#### Tasks & ToDos

- [x] Create random strings as passwords
- [x] Create and manage member users in Azure AD
- [x] Add auto-build rules for username, mail, mail nickname, display name and UPN
- [x] Extend creating/managing users with minimum required attributes only to creating/managing users with all available attributes in Azure AD
- [x] Create and manage ouput file for Azure AD users' credentials
- [x] Implement code to differ between normal users and admins
- [x] Implement code to allow non-default values for username, mail, mail nickname, display name and UPN
- [x] \(Optional) Apply input variable validation rules if necessary to match available resource values
- [ ] \(Optional) Apply input variable validation rules if necessary to match business standards
- [ ] Create and manage modules outputs
- [x] Document module with README.md
- [ ] \(Optional) Review code regularly for possible improvements and updates

### Module 'group'

[Module README](group/README.md)  

#### Tasks & ToDos

- [x] Create and manage groups with static assignment
- [x] Manage static assignments for users, groups and service principals
- [x] Create and manage groups with dynamic assignment
- [x] Merge to dynamically create either static assignment group or dynamic assignement group depending on input variable's values
- [x] Extend creating/managing groups with minimum required attributes only to creating/managing groups with all attributes in Azure AD
- [x] \(Optional) Apply input variable validation rules if necessary to match available resource values
- [ ] \(Optional) Apply input variable validation rules if necessary to match business standards
- [x] Create and manage modules outputs
- [ ] Document module with README.md
- [ ] \(Optional) Review code regularly for possible improvements and updates

### Module 'invitation'

[Module README](invitation/README.md)  

#### Tasks & ToDos

- [x] Create and manage invitations
- [x] \(Optional) Apply input variable validation rules if necessary to match available resource values
- [ ] \(Optional) Apply input variable validation rules if necessary to match business standards
- [x] Create and manage modules outputs
- [ ] Document module with README.md
- [ ] \(Optional) Review code regularly for possible improvements and updates

### Module 'named_location'

[Module README](named_location/README.md)  

#### Tasks & ToDos

- [x] Create and manage ip range based named location
- [x] Create and manage country and region based named location
- [x] Merge to dynamically create either ip range based named location or country and region based named location depending on input variable's values
- [ ] \(Optional) Apply input variable validation rules if necessary to match available resource values
- [ ] \(Optional) Apply input variable validation rules if necessary to match business standards
- [x] Create and manage modules outputs
- [ ] Document module with README.md
- [ ] \(Optional) Review code regularly for possible improvements and updates