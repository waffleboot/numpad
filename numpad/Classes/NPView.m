
#import "NPView.h"
#import "NPDigits.h"
#import "PureLayout.h"

const CGFloat kSpacing = 2.0f;

@interface NumberPadTextField : UITextField @end
@implementation NumberPadTextField
- (CGRect)textRectForBounds:(CGRect)bounds { return CGRectInset(bounds,8,0); }
@end

@interface NPView ()
@property (nonatomic) NSDecimalNumber *amount;
@end

@implementation NPView {
@private
  NPDigits *_digits;
  NSArray<UIButton*> *_buttons;
  UITextField *_amountTextField;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupDefaults];
  }
  return self;
}

- (void)setupDefaults {
  _digits = [NPDigits new];
  _buttons = [self buttons];
  _amountTextField = [self amountTextField];
  UIStackView *stack = [self stack];
  NSArray<UIStackView*> *stacks = [self stacks];
  [self fillStacks:stacks buttons:_buttons];
  [self fillStack:stack stacks:stacks textField:_amountTextField];
  [self addSubview:stack];
  [stack autoPinEdgesToSuperviewEdges];
  self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
  self.layer.cornerRadius = 4.0f;
  self.layer.borderColor = self.backgroundColor.CGColor;
  self.layer.borderWidth = kSpacing;
}

- (UIStackView*)stack {
  UIStackView *stack = [UIStackView new];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.alignment = UIStackViewAlignmentFill;
  stack.distribution = UIStackViewDistributionFillEqually;
  stack.spacing = kSpacing;
  return stack;
}

- (NSArray<UIStackView*>*)stacks {
  NSMutableArray<UIStackView*> *stacks = [NSMutableArray arrayWithCapacity:4];
  for (int i = 0; i < 4; ++i) {
    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.alignment = UIStackViewAlignmentFill;
    stack.distribution = UIStackViewDistributionFillEqually;
    stack.spacing = kSpacing;
    [stacks addObject:stack];
  }
  return stacks;
}

- (NSArray<UIButton*>*)buttons {
  NSMutableArray<UIButton*> *buttons = [NSMutableArray arrayWithCapacity:12];
  for (int i = 0; i < 10; ++i) {
    [buttons addObject:[self button:[NSString stringWithFormat:@"%u", i] tag:i]];
  }
  [buttons addObject:[self button:@"C" tag:10]];
  [buttons addObject:[self button:_digits.decimalSeparator tag:11]];
  return buttons;
}

- (void)clickTag:(int)tag {
  if (tag == 10) {
    [_digits clear];
  } else if (tag == 11) {
    [_digits addDecimalSeparator];
  } else {
    [_digits addDigit:tag];
  }
  _amountTextField.text = _digits.stringValue;
  self.amount = _digits.decimalNumber;
}

- (void)click:(UIButton*)sender {
  [self clickTag:(int)sender.tag];
}

- (UIButton*)button:(NSString*)title tag:(int)tag {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  UIImage *backgroundImageNormal = [NPView imageFromColor:[UIColor whiteColor]];
  UIImage *backgroundImageHighlighted = [NPView imageFromColor:[UIColor colorWithWhite:0.9f alpha:1.0f]];
  UIColor *titleColor = (tag == 10) ? [UIColor orangeColor] : [UIColor colorWithWhite:0.3f alpha:1.0f];
  [button setTitle:title forState:UIControlStateNormal];
  [button setTitleColor:titleColor forState:UIControlStateNormal];
  [button setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
  [button setBackgroundImage:backgroundImageHighlighted forState:UIControlStateHighlighted];
  [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
  button.tag = tag;
  return button;
}

- (void)fillStacks:(NSArray<UIStackView*>*)stacks buttons:(NSArray<UIView*>*)buttons {
  [stacks[0] addArrangedSubview:buttons[1]];
  [stacks[0] addArrangedSubview:buttons[2]];
  [stacks[0] addArrangedSubview:buttons[3]];
  [stacks[1] addArrangedSubview:buttons[4]];
  [stacks[1] addArrangedSubview:buttons[5]];
  [stacks[1] addArrangedSubview:buttons[6]];
  [stacks[2] addArrangedSubview:buttons[7]];
  [stacks[2] addArrangedSubview:buttons[8]];
  [stacks[2] addArrangedSubview:buttons[9]];
  [stacks[3] addArrangedSubview:buttons[10]];
  [stacks[3] addArrangedSubview:buttons[0]];
  [stacks[3] addArrangedSubview:buttons[11]];
}

- (void)fillStack:(UIStackView*)stack stacks:(NSArray<UIView*>*)stacks textField:(UIView*)textField {
  [stack addArrangedSubview:textField];
  [stack addArrangedSubview:stacks[0]];
  [stack addArrangedSubview:stacks[1]];
  [stack addArrangedSubview:stacks[2]];
  [stack addArrangedSubview:stacks[3]];
}

- (UITextField*)amountTextField {
  UITextField *textField = [NumberPadTextField new];
  textField.placeholder = @"0";
  textField.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
  textField.textAlignment = NSTextAlignmentRight;
  textField.userInteractionEnabled = NO;
  textField.backgroundColor = [UIColor whiteColor];
  return textField;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
  CGRect rect = CGRectMake(0, 0, 1, 1);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (void)setFontSize:(CGFloat)fontSize {
  if (_fontSize != fontSize) {
    _fontSize = fontSize;
    _amountTextField.font = [UIFont systemFontOfSize:fontSize];
    for (UIButton *button in _buttons) {
      button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
  }
}

- (void)clear {
  [_digits clear];
  _amountTextField.text = _digits.stringValue;
  self.amount = _digits.decimalNumber;
}

@end
