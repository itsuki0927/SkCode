interface TestProps {
  name?: string;
  description?: string;
}

const list = [];

const Test = ({ name, description }: TestProps) => (
  <div>
    <div>{name}</div>
    <p>{description}</p>
  </div>
);

export default Test;
