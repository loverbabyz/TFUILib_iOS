//
//  DDVehicleViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDVehicleViewController.h"
#import "DDVehicleViewModel.h"

@interface DDVehicleViewController ()

@property (nonatomic, strong) DDVehicleViewModel *viewModel;

@end

@implementation DDVehicleViewController
@dynamic viewModel;

- (void)rightButtonEvent {
    [UIViewController gotoAddViewController:AddTypeVehicel];
}

- (void)bindData {
//    [super bindData];
//    XLFormDescriptor * form;
//    XLFormSectionDescriptor * section;
//    XLFormRowDescriptor * row;
//
//    form = [XLFormDescriptor formDescriptorWithTitle:@"Multivalued Examples"];
//
//    // Multivalued section
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multivalued TextField"
//                                             sectionOptions:XLFormSectionOptionCanReorder | XLFormSectionOptionCanInsert | XLFormSectionOptionCanDelete
//                                          sectionInsertMode:XLFormSectionInsertModeButton];
//    section.multivaluedAddButton.title = @"Add New Tag";
//    section.footerTitle = @"XLFormSectionInsertModeButton sectionType adds a 'Add Item' (Add New Tag) button row as last cell.";
//    // set up the row template
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeName];
//    [[row cellConfig] setObject:@"Tag Name" forKey:@"textField.placeholder"];
//    section.multivaluedRowTemplate = row;
//    [form addFormSection:section];
//
//
//    // Another Multivalued section
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multivalued ActionSheet Selector example"
//                                             sectionOptions:XLFormSectionOptionCanInsert | XLFormSectionOptionCanDelete];
//    section.footerTitle = @"XLFormSectionInsertModeLastRow sectionType adds a '+' icon inside last table view cell allowing us to add a new row.";
//    [form addFormSection:section];
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Tap to select.."];
//    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5"];
//    [section addFormRow:row];
//
//
//    // Another one
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multivalued Push Selector example"
//                                             sectionOptions:XLFormSectionOptionCanInsert | XLFormSectionOptionCanDelete | XLFormSectionOptionCanReorder
//                                          sectionInsertMode:XLFormSectionInsertModeButton];
//    section.footerTitle = @"MultivaluedFormViewController.h";
//    [form addFormSection:section];
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeSelectorPush title:@"Tap to select ;).."];
//    row.selectorOptions = @[@"Option 1", @"Option 2", @"Option 3"];
//    section.multivaluedRowTemplate = [row copy];
//    [section addFormRow:row];
//
//    self.form = form;
}

@end
