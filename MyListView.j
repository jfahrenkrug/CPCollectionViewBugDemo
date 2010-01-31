@import <AppKit/CPCollectionView.j>
 
@implementation MyListView : CPCollectionView
{
    CPCollectionViewItem itemPrototype;
}
 
- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self)
    {
        [self setBackgroundColor:[CPColor colorWithHexString:@"F2F2F2"]];
        [self setMinItemSize:CGSizeMake(226.0, 50.0)];
        [self setMaxItemSize:CGSizeMake(226.0, 50.0)];
        [self setAllowsMultipleSelection:NO];

        itemPrototype = [[CPCollectionViewItem alloc] init];
        [itemPrototype setView:[[LocationItemView alloc] initWithFrame:CGRectMakeZero()]];
        
        [self setItemPrototype:itemPrototype];
    }
 
    return self;
}
 
- (id)getCurrentObject
{
    return [[self content] objectAtIndex:[self getSelectedIndex]] ;
}
 
- (int)getSelectedIndex
{
    return [[self selectionIndexes] firstIndex] ;
}
 
@end

/* -------- the item view ---------- */
@implementation LocationItemView : CPView
{
    CPTextField descriptionField;
    id representedObject;
}

- (void)setRepresentedObject:(id)anObject
{    
    
    if (!descriptionField)
    {
        descriptionField = [[CPTextField alloc] initWithFrame:CGRectMake(10.0, 25.0, 195.0, 20.0)];
        
        [descriptionField setFont:[CPFont boldSystemFontOfSize:12.0]];
        [descriptionField setTextColor:[CPColor blackColor]];
        [self addSubview:descriptionField];
    }

    representedObject = anObject;
    
    
    [descriptionField setStringValue:[anObject description]];
    
    [self setTextColor:representedObject isSelected:NO];
}

- (void)setSelected:(BOOL)isSelected
{
    //alert(isSelected + ": " + representedObject);
    [self setBackgroundColor:isSelected ? [CPColor colorWithHexString:@"045FB4"] : nil];
    [self setTextColor:representedObject isSelected:isSelected];
}

- (void)setTextColor:(id)anObject isSelected:(BOOL)isSelected {
    [descriptionField setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
}

@end